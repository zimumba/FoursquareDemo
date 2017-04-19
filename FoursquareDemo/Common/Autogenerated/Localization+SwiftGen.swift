// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable nesting
// swiftlint:disable variable_name
// swiftlint:disable valid_docs

// COMM: cool implementation but I don't see sense in such a solution when we have NSLocalizedString already
struct L10n {
  /// OK
  static let OK = L10n.tr("OK")
  /// Cancel
  static let Cancel = L10n.tr("Cancel")
  /// Error
  static let ErrorText = L10n.tr("ErrorText")
  /// Loading...
  static let LoadingText = L10n.tr("LoadingText")

  struct Controller {

    struct Title {
      /// Sign In
      static let SignIn = L10n.tr("Controller.Title.SignIn")
      /// User Feed
      static let UserFeed = L10n.tr("Controller.Title.UserFeed")
    }
  }

  struct Error {

    struct Foursquare {

      struct Autherror {
        /// Invalid client
        static let InvalidClient = L10n.tr("Error.Foursquare.AuthError.InvalidClient")
        /// Invalid grant
        static let InvalidGrant = L10n.tr("Error.Foursquare.AuthError.InvalidGrant")
        /// Invalid request
        static let InvalidRequest = L10n.tr("Error.Foursquare.AuthError.InvalidRequest")
        /// Unauthorized client
        static let UnauthorizedClient = L10n.tr("Error.Foursquare.AuthError.UnauthorizedClient")
        /// Unsupported grant
        static let UnsupportedGrant = L10n.tr("Error.Foursquare.AuthError.UnsupportedGrant")
        /// Unknown
        static let Unknown = L10n.tr("Error.Foursquare.AuthError.Unknown")
        /// An error occured when attempting o connect to the Foursquare server
        static let NetworkError = L10n.tr("Error.Foursquare.AuthError.NetworkError")
      }

      struct Authstatus {
        /// Invalid callback URI
        static let InvalidCallback = L10n.tr("Error.Foursquare.AuthStatus.InvalidCallback")
        /// Foursquare is not installed
        static let FoursquareNotInstalled = L10n.tr("Error.Foursquare.AuthStatus.FoursquareNotInstalled")
        /// Invalid client id
        static let InvalidClientId = L10n.tr("Error.Foursquare.AuthStatus.InvalidClientId")
        /// Installed FSQ App doesn't support oauth
        static let FoursquareOAuthNotSupported = L10n.tr("Error.Foursquare.AuthStatus.FoursquareOAuthNotSupported")
        /// Unknown
        static let Unknown = L10n.tr("Error.Foursquare.AuthStatus.Unknown")
      }
    }
  }
}

extension L10n {
  fileprivate static func tr(_ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:enable type_body_length
// swiftlint:enable nesting
// swiftlint:enable variable_name
// swiftlint:enable valid_docs
