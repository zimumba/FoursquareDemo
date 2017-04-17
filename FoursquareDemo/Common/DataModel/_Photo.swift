// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Photo.swift instead.

import Foundation
import CoreData

public enum PhotoAttributes: String {
    case prefix = "prefix"
    case suffix = "suffix"
}

public enum PhotoRelationships: String {
    case user = "user"
}

open class _Photo: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Photo"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Photo.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var prefix: String

    @NSManaged open
    var suffix: String

    // MARK: - Relationships

    @NSManaged open
    var user: User?

}

