//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import AFNetworking
import FastEasyMapping
import CoreData

extension APIClient {

    @discardableResult func getFriends(offset: Int = 0, limit: Int = 10, completion: DefaultFetchCompletionHandler?) -> URLSessionTask {
        let path = APIURLs.oauthPath(APIURLs.getFriendsPath)

        let parameters = [
                "offset": offset,
                "limit": limit
        ]

        return self.get(path, parameters: parameters, progress: nil, success: { [weak self] (_: URLSessionDataTask, responseObject: Any?) in
            self?.parseFriendsResponse(responseObject: responseObject, completion: completion)
        }, failure: { (_: URLSessionDataTask?, error: Error) in
            completion?(nil, error)
        })!
    }

    fileprivate func parseFriendsResponse(responseObject: Any?, completion: DefaultFetchCompletionHandler?) {
        guard let responseObject = responseObject as? [String: AnyObject] else { fatalError("Can not parse response") }
        guard let response = responseObject["response"] as? [String: AnyObject] else { fatalError("Can not parse response") }
        guard let responseFriends = response["friends"] as? [String: AnyObject] else { fatalError("Can not parse response") }

        guard let friendsItems = responseFriends["items"] as? [Any] else {
            completion?(nil, nil)
            return
        }

        let context = serviceLocator().coreDataHelper.importingManagedObjectContext!
        context.perform {
            guard let currentUser = User.currentUser(inContext: context) else {
                completion?(nil, nil)
                return
            }

            guard let friends = FEMDeserializer.collection(fromRepresentation: friendsItems, mapping: User.defaultMapping(), context: context) as? [User] else {
                completion?(nil, nil)
                return
            }

            let allFriends: NSMutableSet = currentUser.friends.mutableCopy() as! NSMutableSet
            allFriends.addObjects(from: friends)
            currentUser.friends = allFriends

            do {
                try context.deepSave()
            } catch {
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
            }

            let objectIDs = friends.map { user -> NSManagedObjectID in
                return user.objectID
            }

            let defaultContext = serviceLocator().coreDataHelper.defaultManagedObjectContext!
            defaultContext.perform {
                completion?(defaultContext.objects(withIDs: objectIDs), nil)
            }
        }
    }
}