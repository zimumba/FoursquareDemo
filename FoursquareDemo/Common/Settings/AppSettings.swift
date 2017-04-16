//
// Created by Antonyo on 4/16/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation

class AppSettings {

    static let notFirstLaunchKey = "notFirstLaunchKey"

    var notFirstLaunch: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: AppSettings.notFirstLaunchKey)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: AppSettings.notFirstLaunchKey)
        }
    }
}
