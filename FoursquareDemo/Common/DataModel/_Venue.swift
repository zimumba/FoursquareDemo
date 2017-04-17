// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Venue.swift instead.

import Foundation
import CoreData

public enum VenueAttributes: String {
    case identifier = "identifier"
    case name = "name"
}

public enum VenueRelationships: String {
    case checkins = "checkins"
}

open class _Venue: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Venue"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Venue.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var identifier: String?

    @NSManaged open
    var name: String?

    // MARK: - Relationships

    @NSManaged open
    var checkins: NSSet

    open func checkinsSet() -> NSMutableSet {
        return self.checkins.mutableCopy() as! NSMutableSet
    }

}

extension _Venue {

    open func addCheckins(_ objects: NSSet) {
        let mutable = self.checkins.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.checkins = mutable.copy() as! NSSet
    }

    open func removeCheckins(_ objects: NSSet) {
        let mutable = self.checkins.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.checkins = mutable.copy() as! NSSet
    }

    open func addCheckinsObject(_ value: Checkin) {
        let mutable = self.checkins.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.checkins = mutable.copy() as! NSSet
    }

    open func removeCheckinsObject(_ value: Checkin) {
        let mutable = self.checkins.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.checkins = mutable.copy() as! NSSet
    }

}

