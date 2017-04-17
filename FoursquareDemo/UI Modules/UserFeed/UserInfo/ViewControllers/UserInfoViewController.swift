//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SDWebImage
import QuartzCore

class UserInfoViewController: UIViewController, UserFeedChildController {

    var didChangeContentHeightHandler: ((CGFloat) -> Void)?

    static let controllerContentHeight = CGFloat(180)

    @IBOutlet fileprivate var fullNameLabel: UILabel!
    @IBOutlet fileprivate var avatarImageView: UIImageView!

    fileprivate var viewModel = UserViewModel()

    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<User> = {
        let fetchRequest = NSFetchRequest<User>(entityName: User.entityName())
        fetchRequest.predicate = NSPredicate(format: "self == %@", self.user.objectID)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: UserAttributes.identifier.rawValue, ascending: true)]
        let fetchedResultsController = NSFetchedResultsController<User>(
                fetchRequest: fetchRequest,
                managedObjectContext: serviceLocator().coreDataHelper.defaultManagedObjectContext,
                sectionNameKeyPath: nil,
                cacheName: nil
        )

        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Database issue")
        }

        return fetchedResultsController
    }()

    var user: User {
        didSet {
            self.reloadInterface()
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        guard let currentUser = User.currentUser() else { fatalError("Unexpected current user is empty") }

        self.user = currentUser

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.prepareInterface()
        self.reloadInterface()
        self.reloadData()
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

    fileprivate func reloadData() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            fatalError("Unexpected database issue")
        }

        serviceLocator().apiClient.getCurrentUser { [weak self] user, error in
            if let error = error {
                let alertController = AlertsFactory.errorAlertController(withErrorMessage: error.localizedDescription)
                self?.present(alertController, animated: true)
            }
        }
    }

    // MARK: UserFeedChildController
    func contentHeight() -> CGFloat {
        return UserInfoViewController.controllerContentHeight
    }
}

extension UserInfoViewController: NSFetchedResultsControllerDelegate {

    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let user = controller.fetchedObjects?.last as? User else { fatalError("Unexpected current user is empty") }

        self.user = user
    }
}
