//
// Created by Antonyo on 4/16/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import KeychainSwift

class UserSession {

    let keychain = KeychainSwift()

    static let foursquareAccessTokenKey = "foursquareAccessToken"

    var foursquareAccessToken: String? {
        set {
            if let newValue = newValue {
                self.keychain.set(newValue, forKey: UserSession.foursquareAccessTokenKey)
            } else {
                self.keychain.delete(UserSession.foursquareAccessTokenKey)
            }
        }
        get {
            return self.keychain.get(UserSession.foursquareAccessTokenKey)
        }
    }

    static func logout() {
        UserSession().foursquareAccessToken = nil
    }
}
