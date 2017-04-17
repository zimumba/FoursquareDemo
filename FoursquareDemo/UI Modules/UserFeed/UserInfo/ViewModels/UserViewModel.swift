//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation

class UserViewModel {

    var user: User? {
        didSet {
            self.reloadData()
        }
    }

    var fullName: String = ""

    fileprivate func reloadData() {
        self.fullName = self.user?.fullName ?? ""
    }

    func avatarURLForSize(_ size: CGSize) -> URL? {
        return PhotosHelper.getAppropriatePhotoURL(photo: self.user?.photo, size: size)
    }
}
