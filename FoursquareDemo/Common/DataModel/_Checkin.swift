// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Checkin.swift instead.

import Foundation
import CoreData

public enum CheckinAttributes: String {
    case createdAt = "createdAt"
    case identifier = "identifier"
}

public enum CheckinRelationships: String {
    case user = "user"
    case venue = "venue"
}

open class _Checkin: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Checkin"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Checkin.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var createdAt: NSNumber?

    @NSManaged open
    var identifier: String?

    // MARK: - Relationships

    @NSManaged open
    var user: User?

    @NSManaged open
    var venue: Venue?

}

