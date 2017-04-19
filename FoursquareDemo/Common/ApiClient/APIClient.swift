//
// Created by Antonyo on 4/15/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import AFNetworking

// COMM: APIClient is a God Object. It performs all networking tasks, its extensions request, parse and save data to CoreData. In small project it is even a good idea but in the bigger one it will backfire with complicated architecture fully dependent on one class - APIClient

class APIClient: AFHTTPSessionManager {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(baseURL url: URL?) {
        super.init(baseURL: url, sessionConfiguration: nil)

        self.requestSerializer = AFJSONRequestSerializer();
        self.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        self.requestSerializer.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData

        self.responseSerializer = AFJSONResponseSerializer();

        AFNetworkActivityIndicatorManager.shared().isEnabled = true
    }
}
