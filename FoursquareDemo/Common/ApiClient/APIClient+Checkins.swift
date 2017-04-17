//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import AFNetworking
import FastEasyMapping
import CoreData

extension APIClient {

    @discardableResult func getCheckins(offset: Int = 0, limit: Int = 10, completion: DefaultFetchCompletionHandler?) -> URLSessionTask {
        let path = APIURLs.oauthPath(APIURLs.getCheckinsPath)

        let parameters = [
                "offset": offset,
                "limit": limit
        ]

        return self.get(path, parameters: parameters, progress: nil, success: { [weak self] (_: URLSessionDataTask, responseObject: Any?) in
            self?.parseCheckinsResponse(responseObject: responseObject, completion: completion)
        }, failure: { (_: URLSessionDataTask?, error: Error) in
            completion?(nil, error)
        })!
    }

    fileprivate func parseCheckinsResponse(responseObject: Any?, completion: DefaultFetchCompletionHandler?) {
        guard let responseObject = responseObject as? [String: AnyObject] else { fatalError("Can not parse response") }
        guard let response = responseObject["response"] as? [String: AnyObject] else { fatalError("Can not parse response") }
        guard let responseCheckins = response["checkins"] as? [String: AnyObject] else { fatalError("Can not parse response") }

        guard let checkinsItems = responseCheckins["items"] as? [Any] else {
            completion?(nil, nil)
            return
        }

        let context = serviceLocator().coreDataHelper.importingManagedObjectContext!
        context.perform {
            guard let currentUser = User.currentUser(inContext: context) else {
                completion?(nil, nil)
                return
            }

            guard let checkins = FEMDeserializer.collection(fromRepresentation: checkinsItems, mapping: Checkin.defaultMapping(), context: context) as? [Checkin] else {
                completion?(nil, nil)
                return
            }

            // Removed friend won't be deleted
            for checkin in checkins {
                checkin.user = currentUser
            }

            do {
                try context.deepSave()
            } catch {
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
            }

            let objectIDs = checkins.map { user -> NSManagedObjectID in
                return user.objectID
            }

            let defaultContext = serviceLocator().coreDataHelper.defaultManagedObjectContext!
            defaultContext.perform {
                completion?(defaultContext.objects(withIDs: objectIDs), nil)
            }
        }
    }
}
