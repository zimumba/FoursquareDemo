//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit

class FriendsViewController: UIViewController {

    fileprivate var networkTask: URLSessionTask?

    deinit {
        self.networkTask?.cancel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.reloadData()
    }

    fileprivate func reloadData() {
        self.networkTask?.cancel()
        self.networkTask = serviceLocator().apiClient.getFriends() { [weak self] friends, Error in
            
        }
    }
}

extension FriendsViewController: UserFeedChildController {

    func contentHeight() -> CGFloat {
        return 0
    }
}
