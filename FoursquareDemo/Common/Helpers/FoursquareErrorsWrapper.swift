//
// Created by Antonyo on 4/16/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation

class FoursquareErrorsWrapper {

    // MARK: Auth Status
    static func error(forAuthStatusCode authStatusCode: FSOAuthStatusCode) -> Error {
        return NSError(domain:self.errorMessage(forAuthStatusCode: authStatusCode), code:Int(authStatusCode.rawValue))
    }

    static fileprivate func errorMessage(forAuthStatusCode authStatusCode: FSOAuthStatusCode) -> String {
        switch (authStatusCode) {
        case FSOAuthStatusCode.success:
           return ""

        case FSOAuthStatusCode.errorInvalidCallback:
            return L10n.Error.Foursquare.Authstatus.InvalidCallback

        case FSOAuthStatusCode.errorFoursquareNotInstalled:
            return L10n.Error.Foursquare.Authstatus.FoursquareNotInstalled

        case FSOAuthStatusCode.errorInvalidClientID:
            return L10n.Error.Foursquare.Authstatus.InvalidClientId

        case FSOAuthStatusCode.errorFoursquareOAuthNotSupported:
            return L10n.Error.Foursquare.Authstatus.FoursquareOAuthNotSupported
        }
    }

    // MARK: Auth Error
    static func error(forErrorCode errorCode: FSOAuthErrorCode) -> Error {
        return NSError(domain:self.errorMessage(forErrorCode: errorCode), code:Int(errorCode.rawValue))
    }

    static fileprivate func errorMessage(forErrorCode errorCode: FSOAuthErrorCode) -> String {
        switch (errorCode) {
        case FSOAuthErrorCode.none:
            return ""

        case FSOAuthErrorCode.invalidClient:
            return L10n.Error.Foursquare.Autherror.InvalidClient

        case FSOAuthErrorCode.invalidGrant:
            return L10n.Error.Foursquare.Autherror.InvalidGrant

        case FSOAuthErrorCode.invalidRequest:
            return L10n.Error.Foursquare.Autherror.InvalidRequest

        case FSOAuthErrorCode.unauthorizedClient:
            return L10n.Error.Foursquare.Autherror.UnauthorizedClient

        case FSOAuthErrorCode.unsupportedGrantType:
            return L10n.Error.Foursquare.Autherror.UnsupportedGrant

        case FSOAuthErrorCode.unknown:
            return L10n.Error.Foursquare.Autherror.Unknown
        }
    }

    // MARK: Network Error
    static func networkError() -> Error {
        return NSError(domain: L10n.Error.Foursquare.Autherror.NetworkError, code: NSURLErrorTimedOut)
    }
}
