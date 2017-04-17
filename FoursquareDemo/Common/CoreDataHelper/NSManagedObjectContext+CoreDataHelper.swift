//
// Created by Antonyo on 4/16/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {

    func deepSave() throws {
        var context: NSManagedObjectContext = self

        while context.hasChanges {
            var savingError: Error?
            context.performAndWait {
                do {
                    try context.save()
                } catch {
                    savingError = error
                }
            }

            if let error = savingError {
                throw error
            } else if let parent = context.parent {
                context = parent
            } else {
                break
            }
        }
    }

    func objects<T: NSManagedObject>(withIDs identifiers: [NSManagedObjectID]?) -> [T]? {
        if let identifiers = identifiers, identifiers.count > 0 {
            return identifiers.map { objectID -> T in
                guard let object = self.object(with: objectID) as? T else { fatalError("Unexpected entity type") }

                return object
            }
        } else {
            return nil
        }
    }
}