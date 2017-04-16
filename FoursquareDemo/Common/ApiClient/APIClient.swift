//
// Created by Antonyo on 4/15/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import AFNetworking

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
