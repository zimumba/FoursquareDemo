//
// Created by Antonyo on 4/15/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation

class APIURLs {

    static let baseURL = "https://api.foursquare.com"

    static let getCurrentUserPath = "v2/users/self"
    static let getFriendsPath = "v2/users/self/friends"
    static let getCheckinsPath = "v2/users/self/checkins"

    static func oauthPath(_ path: String) -> String {
        if let token = serviceLocator().userSession.foursquareAccessToken {
            return "\(path)?oauth_token=\(token)&v=\(serviceLocator().dateFormattersLocator.oauthVersionDateFormatter.string(from: Date()))"
        } else {
            return path
        }
    }
}
