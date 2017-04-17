// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.swift instead.

import Foundation
import CoreData

public enum UserAttributes: String {
    case firstName = "firstName"
    case gender = "gender"
    case identifier = "identifier"
    case lastName = "lastName"
}

public enum UserRelationships: String {
    case checkins = "checkins"
    case friends = "friends"
    case friendsReversal = "friendsReversal"
    case photo = "photo"
}

open class _User: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "User"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _User.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var firstName: String?

    @NSManaged open
    var gender: String?

    @NSManaged open
    var identifier: String?

    @NSManaged open
    var lastName: String?

    // MARK: - Relationships

    @NSManaged open
    var checkins: NSSet

    open func checkinsSet() -> NSMutableSet {
        return self.checkins.mutableCopy() as! NSMutableSet
    }

    @NSManaged open
    var friends: NSSet

    open func friendsSet() -> NSMutableSet {
        return self.friends.mutableCopy() as! NSMutableSet
    }

    @NSManaged open
    var friendsReversal: NSSet

    open func friendsReversalSet() -> NSMutableSet {
        return self.friendsReversal.mutableCopy() as! NSMutableSet
    }

    @NSManaged open
    var photo: Photo?

}

extension _User {

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

extension _User {

    open func addFriends(_ objects: NSSet) {
        let mutable = self.friends.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.friends = mutable.copy() as! NSSet
    }

    open func removeFriends(_ objects: NSSet) {
        let mutable = self.friends.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.friends = mutable.copy() as! NSSet
    }

    open func addFriendsObject(_ value: User) {
        let mutable = self.friends.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.friends = mutable.copy() as! NSSet
    }

    open func removeFriendsObject(_ value: User) {
        let mutable = self.friends.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.friends = mutable.copy() as! NSSet
    }

}

extension _User {

    open func addFriendsReversal(_ objects: NSSet) {
        let mutable = self.friendsReversal.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.friendsReversal = mutable.copy() as! NSSet
    }

    open func removeFriendsReversal(_ objects: NSSet) {
        let mutable = self.friendsReversal.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.friendsReversal = mutable.copy() as! NSSet
    }

    open func addFriendsReversalObject(_ value: User) {
        let mutable = self.friendsReversal.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.friendsReversal = mutable.copy() as! NSSet
    }

    open func removeFriendsReversalObject(_ value: User) {
        let mutable = self.friendsReversal.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.friendsReversal = mutable.copy() as! NSSet
    }

}

