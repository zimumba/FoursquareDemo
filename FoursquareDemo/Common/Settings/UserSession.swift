//
// Created by Antonyo on 4/16/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import KeychainSwift

class UserSession {

    let keychain = KeychainSwift()

    static let foursquareAccessGrantKey = "foursquareAccessGrant"
    static let foursquareAccessTokenKey = "foursquareAccessToken"

    static let currentUserIDKey = "currentUserID"

    var foursquareAccessGrant: String? {
        set {
            if let newValue = newValue {
                self.keychain.set(newValue, forKey: UserSession.foursquareAccessGrantKey)
            } else {
                self.keychain.delete(UserSession.foursquareAccessGrantKey)
            }
        }
        get {
            return self.keychain.get(UserSession.foursquareAccessGrantKey)
        }
    }

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

    var currentUserID: String? {
        set {
            if let newValue = newValue {
                self.keychain.set(newValue, forKey: UserSession.currentUserIDKey)
            } else {
                self.keychain.delete(UserSession.currentUserIDKey)
            }
        }
        get {
            return self.keychain.get(UserSession.currentUserIDKey)
        }
    }

    func logout() {
        self.foursquareAccessGrant = nil
        self.foursquareAccessToken = nil
        self.currentUserID = nil
    }
}
