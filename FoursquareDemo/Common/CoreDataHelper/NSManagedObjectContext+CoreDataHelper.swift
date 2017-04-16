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
}