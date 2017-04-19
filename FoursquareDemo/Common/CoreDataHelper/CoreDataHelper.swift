//
// Created by Antonyo on 4/15/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper {

// If enabled syncing works in both ways:
// in-memory <-> persistent storage
// it's required for iCloud syncing f. e.
    // COMM: this flag won't work as the only method that is using it - setupRootManagedObjectContext() - is called synchronously in init. And you cannot set the property before init.
    var shouldObserveRootContextChanges: Bool = false

    var rootManagedObjectContext: NSManagedObjectContext!
    var defaultManagedObjectContext: NSManagedObjectContext!
    var importingManagedObjectContext: NSManagedObjectContext!

// COMM: the init method is too complicated. It should be syncronous and should set up only the instance's fields. The async method of the CoreData stack set up should be called separately
// COMM: the method is pretty complicated and is hard to be read
    init(modelName: String, bundle: Bundle = Bundle.main, completion: DefaultCompletionHandler? = nil) {
        guard let modelURL = bundle.url(forResource: modelName, withExtension: "momd") else { fatalError("Unexpected data model path") }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else { fatalError("Can not create model") }
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)

        self.setupRootManagedObjectContext(withPersistentStoreCoordinator: coordinator)
        self.setupDefaultContext()

        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).last else { fatalError("Can't find documents directory") }
        let storeURL = documentsURL.appendingPathComponent("\(modelName).sqlite")

        DispatchQueue.global(qos: .default).async {
            let options = [
                    NSMigratePersistentStoresAutomaticallyOption: true,
                    NSInferMappingModelAutomaticallyOption: true
            ]

            guard let persistentStoreCoordinator = self.rootManagedObjectContext.persistentStoreCoordinator else { fatalError("Can't access to rootManagedObjectContext's persistentStoreCoordinator") }

            do {
                try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
                DispatchQueue.main.async {
                    self.setupImportingManagedObjectContext()
                    completion?(nil)
                }
            } catch  {
                DispatchQueue.main.async {
                    completion?(error)
                }
            }
        }
    }

    func createContext(concurrencyType: NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: concurrencyType)
        context.parent = self.defaultManagedObjectContext
        self.subscribeToContextChanges(context: context)

        return context
    }

    fileprivate func setupRootManagedObjectContext(withPersistentStoreCoordinator persistentStoreCoordinator: NSPersistentStoreCoordinator) {
        self.rootManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        self.rootManagedObjectContext.performAndWait {
            self.rootManagedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
        }
        self.rootManagedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        self.subscribeToContextChanges(context: self.rootManagedObjectContext)

        if self.shouldObserveRootContextChanges {
            self.subscribeToRootContextChanges(rootContext: self.rootManagedObjectContext)
        }
    }

    fileprivate func setupDefaultContext() {
        self.defaultManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.defaultManagedObjectContext.parent = self.rootManagedObjectContext
        self.subscribeToContextChanges(context: self.defaultManagedObjectContext)
    }

    fileprivate func setupImportingManagedObjectContext() {
        self.importingManagedObjectContext = self.createContext(concurrencyType: .privateQueueConcurrencyType)
    }

    // MARK: Subscribing
    fileprivate func subscribeToRootContextChanges(rootContext: NSManagedObjectContext) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.NSManagedObjectContextDidSave, object: rootContext, queue: .main) { [weak self] notification in
            self?.defaultManagedObjectContext.perform {
                self?.defaultManagedObjectContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }

    fileprivate func subscribeToContextChanges(context: NSManagedObjectContext) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.NSManagedObjectContextWillSave, object: context, queue: .main) { [weak self] notification in
            guard let context = notification.object as? NSManagedObjectContext else { return }

            context.perform {
                self?.obtainPermanentIDs(objects: Array(context.insertedObjects), context: context)
                self?.obtainPermanentIDs(objects: Array(context.updatedObjects), context: context)
            }
        }
    }

    fileprivate func obtainPermanentIDs(objects: [NSManagedObject]?, context: NSManagedObjectContext) {
        if let objects = objects, objects.count > 0 {
            do {
                try context.obtainPermanentIDs(for: objects)
            } catch {
                print("Error during saving Importing context: \(context). Error: \(error)")
            }
        }
    }
}
