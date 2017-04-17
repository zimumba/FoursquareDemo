//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet fileprivate var fullNameLabel: UILabel!
    @IBOutlet fileprivate var avatarImageView: UIImageView!

    fileprivate var viewModel = UserViewModel()

    var user: User? {
        didSet {
            self.reloadInterface()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.prepareInterface()
    }

    fileprivate func prepareInterface() {
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.contentMode = .scaleAspectFill
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width / 2
    }

    fileprivate func reloadInterface() {
        self.viewModel.user = self.user

        self.fullNameLabel.text = self.viewModel.fullName
        self.avatarImageView.sd_setImage(with: self.viewModel.avatarURLForSize(self.avatarImageView.frame.size), placeholderImage: UIImage.defaultPlaceholder)
    }
}
