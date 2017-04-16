//
// Created by Antonyo on 4/16/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit

class AlertsFactory {

    static func infoAlertController(withMessage message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: L10n.OK, style: .default))

        return alertController
    }

    static func errorAlertController(withErrorMessage errorMessage: String?) -> UIAlertController {
        let alertController = UIAlertController(title: L10n.Error, message: errorMessage, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: L10n.OK, style: .default))

        return alertController
    }
}
