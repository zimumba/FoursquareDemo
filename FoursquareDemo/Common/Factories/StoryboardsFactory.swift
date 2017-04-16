//
// Created by Antonyo on 4/16/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit

class StoryboardsFactory {

    static func authorizationStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "AuthorizationStoryboard", bundle: nil)
    }

    static func userFeedStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "UserFeedStoryboard", bundle: nil)
    }
}
