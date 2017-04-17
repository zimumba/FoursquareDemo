//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation

class CheckinViewModel {

    var checkin: Checkin? {
        didSet {
            self.reloadData()
        }
    }

    var venueName: String = ""
    var creationDateString: String = ""

    fileprivate func reloadData() {
        self.venueName = self.checkin?.venue?.name ?? ""

        if let creationDate = self.checkin?.creationDate {
            self.creationDateString = serviceLocator().dateFormattersLocator.simpleDateFormatter.string(from: creationDate)
        } else {
            self.creationDateString = ""
        }

    }
}
