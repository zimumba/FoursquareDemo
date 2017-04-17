//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation

class LogoutWrapper {

    static func logout() {
        serviceLocator().userSession.logout()

        ScreenTransitionsHelper.transitionToAuthorizationScreen()
    }
}
