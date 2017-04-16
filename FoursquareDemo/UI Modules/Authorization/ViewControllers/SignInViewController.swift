//
// Created by Antonyo on 4/16/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class SignInViewController: UIViewController {

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.title = L10n.Controller.Title.SignIn
    }

    @IBAction fileprivate func signInButtonAction(_: AnyObject) {
        serviceLocator().foursquareAuthHelper.requestAccessGrant { [weak self] token, error in
            if let error = error {
                let alertController = AlertsFactory.errorAlertController(withErrorMessage: error.localizedDescription)
                self?.present(alertController, animated: true)
            } else {
                serviceLocator().userSession.foursquareAccessGrant = token

                SVProgressHUD.show(withStatus: L10n.LoadingText)
                serviceLocator().foursquareAuthHelper.requestAccessToken(code: token!) { token, error in
                    SVProgressHUD.dismiss()

                    serviceLocator().userSession.foursquareAccessToken = token

                    ScreenTransitionsHelper.transitionToUserFeedScreen()
                }
            }
        }
    }
}
