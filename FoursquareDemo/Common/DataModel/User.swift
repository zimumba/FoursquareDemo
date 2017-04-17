import Foundation
import CoreData

@objc(User)
open class User: _User {

    static func currentUser() -> User? {
        guard let currentUserID = serviceLocator().userSession.currentUserID else { return nil}

        let fetchRequest = NSFetchRequest<User>(entityName: User.entityName())
        fetchRequest.predicate = NSPredicate(format: "%K == %@", UserAttributes.identifier.rawValue, currentUserID)

        let context = serviceLocator().coreDataHelper.defaultManagedObjectContext!

        do {
            guard let user = try context.fetch(fetchRequest).first else { fatalError("Can not fetch current user") }

            return user
        } catch {
            fatalError("Can not fetch current user")
        }
    }

    var fullName: String {
        if let firstName = self.firstName, firstName.characters.count > 0 {
            if let lastName = self.lastName, lastName.characters.count > 0 {
                return "\(firstName) \(lastName)"
            } else {
                return firstName
            }
        } else {
            return self.lastName ?? ""
        }
    }
}
