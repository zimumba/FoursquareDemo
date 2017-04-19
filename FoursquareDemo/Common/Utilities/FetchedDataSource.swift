//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import CoreData

// COMM: generic type "T" name is not descriptive.
class FetchedDataSource<T: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {

    fileprivate var entityName: String
    fileprivate var sortDescriptors: [NSSortDescriptor]
    fileprivate var sectionNameKeyPath: String?
    fileprivate var cacheName: String?

    var didChangeContentHandler: DefaultEmptyHandler?

    var predicate: NSPredicate {
        didSet {
            self.fetchedResultsController.fetchRequest.predicate = self.predicate

            self.performFetch()
        }
    }

    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<T> = {
        let fetchRequest = NSFetchRequest<T>(entityName: self.entityName)
        fetchRequest.predicate = self.predicate
        fetchRequest.sortDescriptors = self.sortDescriptors

        let fetchedResultsController = NSFetchedResultsController<T>(
                fetchRequest: fetchRequest,
                managedObjectContext: serviceLocator().coreDataHelper.defaultManagedObjectContext,
                sectionNameKeyPath: self.sectionNameKeyPath,
                cacheName: self.cacheName
        )

        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Unexpected database issue")
        }

        return fetchedResultsController
    }()

    init(entityName: String, predicate: NSPredicate, sortDescriptors: [NSSortDescriptor], sectionNameKeyPath: String? = nil, cacheName: String? = nil) {
        self.entityName = entityName
        self.predicate = predicate
        self.sortDescriptors = sortDescriptors
        self.sectionNameKeyPath = sectionNameKeyPath
        self.cacheName = cacheName

        super.init()
    }

    func numberOfSections() -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    func numberOfRows(inSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[section] else { fatalError("Unexpected Section") }

        return sectionInfo.numberOfObjects
    }

    func totalObjectsCount() -> Int {
        return self.fetchedResultsController.fetchedObjects?.count ?? 0
    }

    func object(at indexPath: IndexPath) -> T {
        return self.fetchedResultsController.object(at: indexPath)
    }

    fileprivate func performFetch() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            fatalError("Unexpected database issue")
        }
    }

    // MARK: NSFetchedResultsControllerDelegate
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.didChangeContentHandler?()
    }
}
