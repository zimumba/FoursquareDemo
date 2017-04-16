//
// Created by Antonyo on 4/16/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit

class ScreenTransitionsHelper {

    static func transitionToUserFeedScreen() {
        if let window = (UIApplication.shared.delegate as! AppDelegate).window {
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = StoryboardsFactory.userFeedStoryboard().instantiateInitialViewController()
            }, completion: nil)
        }
    }

    static func transitionToAuthorizationScreen() {
        if let window = (UIApplication.shared.delegate as! AppDelegate).window {
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = StoryboardsFactory.authorizationStoryboard().instantiateInitialViewController()
            }, completion: nil)
        }
    }
}
