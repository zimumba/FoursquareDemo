//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import AFNetworking
import FastEasyMapping

extension APIClient {

    @discardableResult func getCurrentUser(completion: ((User?, Error?) -> Void)?) -> URLSessionTask {
        let path = APIURLs.oauthPath(APIURLs.getCurrentUserPath)

        return self.get(path, parameters: nil, progress: nil, success: { [weak self] (_: URLSessionDataTask, responseObject: Any?) in
            self?.parseUserResponse(responseObject: responseObject, completion: completion)
        }, failure: { (_: URLSessionDataTask?, error: Error) in
            completion?(nil, error)
        })!
    }

    fileprivate func parseUserResponse(responseObject: Any?, completion: ((User?, Error?) -> Void)?) {
        guard let responseObject = responseObject as? [String: AnyObject] else { fatalError("Can not parse response") }
        guard let response = responseObject["response"] as? [String: AnyObject] else { fatalError("Can not parse response") }

        let context = serviceLocator().coreDataHelper.importingManagedObjectContext!
        context.perform {
            guard let user = FEMDeserializer.object(fromRepresentation: response, mapping: User.defaultMapping(), context: context) as? User else { fatalError("Can not parse response") }

            let objectID = user.objectID

            let defaultContext = serviceLocator().coreDataHelper.defaultManagedObjectContext!
            defaultContext.perform {
                completion?(defaultContext.object(with: objectID) as? User, nil)
            }
        }
    }
}
