//
// Created by Antonyo on 4/15/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit

typealias DefaultCompletionHandler = (Error?) -> Void
typealias DefaultEmptyHandler = (Void) -> Void
typealias DefaultFetchCompletionHandler = (Any?, Error?) -> Void

// COMM: A bit confusing method placement. I think it should be located in ServiceLocator.swift file
func serviceLocator() -> ServiceLocator {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("Can't access to AppDelegate") }
    return appDelegate.serviceLocator
}
