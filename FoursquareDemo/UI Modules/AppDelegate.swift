//
//  AppDelegate.swift
//  FoursquareDemo
//
//  Created by Antonyo on 4/12/17.
//  Copyright © 2017 aoli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var serviceLocator: ServiceLocator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { fatalError("Window not found") }

        self.serviceLocator = ServiceLocator()

        var controller: UIViewController!
        if self.serviceLocator.userSession.foursquareAccessToken != nil {
            controller = StoryboardsFactory.userFeedStoryboard().instantiateInitialViewController()
        } else {
            controller = StoryboardsFactory.authorizationStoryboard().instantiateInitialViewController()
        }

        window.rootViewController = controller
        window.makeKeyAndVisible()

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
        return self.serviceLocator.foursquareAuthHelper.application(app, open: url, options: options)
    }
}

