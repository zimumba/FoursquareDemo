//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation

protocol UserFeedChildController {

    func contentHeight() -> CGFloat

    var didChangeContentHeightHandler: ((CGFloat) -> Void)? {get set}
}