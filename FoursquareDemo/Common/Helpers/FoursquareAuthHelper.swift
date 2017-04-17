//
// Created by Antonyo on 4/16/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation

typealias FoursquareAuthHelperCompletionHandler = (_ token : String?, _ error : Error?) -> Void

class FoursquareAuthHelper {

    static let foursquareClientID = "GKVVLFFQP4M4VKKFZTE0DE3MDEMNF5LT1NOOLGR335GAHVQX"
    static let foursquareClientSecret = "LKSFNV54PSXWJQBA11AGM2AUFRAJCMO4BEUMQOXDLAIESOZA"
    static let foursquareCallbackURLKey = "FoursquareCallbackURL"

    fileprivate var completionHandler: FoursquareAuthHelperCompletionHandler?

    func requestAccessGrant(completion: FoursquareAuthHelperCompletionHandler?) {
        guard let foursquareCallbackURL = Bundle.main.infoDictionary?[FoursquareAuthHelper.foursquareCallbackURLKey] as? String else { fatalError("Please setup 'FoursquareCallbackURL' into Info.plist") }
        guard let window = (UIApplication.shared.delegate as! AppDelegate).window else { fatalError("Can't get access to main window") }
        guard let rootViewController = window.rootViewController else { fatalError("Can't get access to rootViewController") }

        self.completionHandler = completion

        let statuscode: FSOAuthStatusCode = FSOAuth.shared().authorizeUser(
                usingClientId: FoursquareAuthHelper.foursquareClientID,
                nativeURICallbackString: foursquareCallbackURL,
                universalURICallbackString: nil,
                allowShowingAppStore: true,
                presentFrom: rootViewController)

        switch statuscode {
        case .success, .errorFoursquareNotInstalled:
            break

        default:
            self.completionHandler?(nil, FoursquareErrorsWrapper.error(forAuthStatusCode: statuscode))
            self.completionHandler = nil
        }
    }

    func requestAccessToken(code: String, completion: FoursquareAuthHelperCompletionHandler?) {
        guard let foursquareCallbackURL = Bundle.main.infoDictionary?[FoursquareAuthHelper.foursquareCallbackURLKey] as? String else { fatalError("Please setup 'FoursquareCallbackURL' into Info.plist") }

        FSOAuth.shared().requestAccessToken(
                forCode: code,
                clientId: FoursquareAuthHelper.foursquareClientID,
                callbackURIString: foursquareCallbackURL,
                clientSecret: FoursquareAuthHelper.foursquareClientSecret) { (authToken, requestCompleted, errorCode) in
            if (requestCompleted) {
                if (errorCode == FSOAuthErrorCode.none) {
                    completion?(authToken, nil)
                } else {
                    completion?(nil, FoursquareErrorsWrapper.error(forErrorCode: errorCode))
                }
            } else {
                completion?(nil, FoursquareErrorsWrapper.networkError())
            }
        }
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
        guard let foursquareCallbackURLString = Bundle.main.infoDictionary?[FoursquareAuthHelper.foursquareCallbackURLKey] as? String else { fatalError("Please setup 'FoursquareCallbackURL' into Info.plist") }
        guard let foursquareCallbackURL = URL(string: foursquareCallbackURLString) else { fatalError("Can not parse 'FoursquareCallbackURL'") }

        if url.scheme == foursquareCallbackURL.scheme {
            var errorCode: FSOAuthErrorCode = FSOAuthErrorCode.none

            let accessGrant = FSOAuth.shared().accessCode(forFSOAuthURL: url, error: &errorCode)

            if (errorCode == FSOAuthErrorCode.none) {
                if let accessGrant = accessGrant {
                    self.completionHandler?(accessGrant, nil)
                } else {
                    self.completionHandler?(nil, FoursquareErrorsWrapper.error(forErrorCode: FSOAuthErrorCode.unknown))
                }
            } else {
                self.completionHandler?(nil, FoursquareErrorsWrapper.error(forErrorCode: errorCode))
            }

            self.completionHandler = nil

            return true
        } else {
            return false
        }
    }
}
