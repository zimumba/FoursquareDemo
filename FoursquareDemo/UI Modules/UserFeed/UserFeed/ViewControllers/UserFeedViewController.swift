//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit

enum UserFeedViewControllerSections: Int {
    case info
    case friends
    case checkins
}

class UserFeedViewController: UITableViewController {

    fileprivate var userFeedChildControllers = [UserFeedViewControllerSections: UserFeedChildController]()

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.title = L10n.Controller.Title.UserFeed
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard let controller = segue.destination as? UserFeedChildController else { return }

        var _controller = controller

        _controller.didChangeContentHeightHandler = { [weak self] _ in
            self?.tableView.reloadData()
        }

        if let controller = controller as? UserInfoViewController {
            self.userFeedChildControllers[UserFeedViewControllerSections.info] = controller
        } else if let controller = controller as? FriendsViewController {
            self.userFeedChildControllers[UserFeedViewControllerSections.friends] = controller
        } else if let controller = controller as? CheckinsViewController {
            self.userFeedChildControllers[UserFeedViewControllerSections.checkins] = controller
        } else {
            fatalError("Unexpected child controller")
        }
    }

    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = UserFeedViewControllerSections(rawValue: indexPath.section) else { fatalError("Unexpected section") }

        if let controller = self.userFeedChildControllers[section] {
            return controller.contentHeight()
        } else {
            return 0
        }
    }

    @IBAction fileprivate func logoutButtonAction() {
        LogoutWrapper.logout()
    }
}
