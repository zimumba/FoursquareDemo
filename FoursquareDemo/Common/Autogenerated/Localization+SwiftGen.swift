// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable nesting
// swiftlint:disable variable_name
// swiftlint:disable valid_docs

struct L10n {
  /// OK
  static let OK = L10n.tr("OK")
  /// Cancel
  static let Cancel = L10n.tr("Cancel")
  /// Error
  static let Error = L10n.tr("Error")

  struct Controller {

    struct Title {
      /// Sign In
      static let SignIn = L10n.tr("Controller.Title.SignIn")
      /// User Feed
      static let UserFeed = L10n.tr("Controller.Title.UserFeed")
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
