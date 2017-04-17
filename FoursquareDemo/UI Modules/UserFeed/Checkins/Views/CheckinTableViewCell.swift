//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit

class CheckinTableViewCell: UITableViewCell {

    @IBOutlet fileprivate var venueNameLabel: UILabel!
    @IBOutlet fileprivate var creationDateLabel: UILabel!

    fileprivate var viewModel = CheckinViewModel()

    var checkin: Checkin? {
        didSet {
            self.reloadInterface()
        }
    }

    fileprivate func reloadInterface() {
        self.viewModel.checkin = self.checkin

        self.venueNameLabel.text = self.viewModel.venueName
        self.creationDateLabel.text = self.viewModel.creationDateString
    }
}
