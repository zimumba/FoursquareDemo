//
// Created by Antonyo on 4/15/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit

class ServiceLocator {

    var coreDataHelper: CoreDataHelper = CoreDataHelper(modelName: "FoursquareDemoDataModel")
    var apiClient: APIClient = APIClient(baseURL: URL(string: APIURLs.baseURL))
    var userSession: UserSession = UserSession()
    var appSettings: AppSettings = AppSettings()
    var foursquareAuthHelper: FoursquareAuthHelper = FoursquareAuthHelper()

    init() {
        if !self.appSettings.notFirstLaunch {
            UserSession.logout()
            self.appSettings.notFirstLaunch = true
        }
    }
}
