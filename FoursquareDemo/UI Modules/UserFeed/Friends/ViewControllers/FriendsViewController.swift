//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit

class FriendsViewController: UserFeedBasicViewController {

    override func setupDataSource() {
        guard let currentUser = User.currentUser() else { fatalError("Unexpected current user is empty") }

        let predicate = NSPredicate(format: "SUBQUERY(%K, $reversalFriend, $reversalFriend == %@).@count > 0", UserRelationships.friendsReversal.rawValue, currentUser)
        let sortDescriptors = [
            NSSortDescriptor(key: UserAttributes.lastName.rawValue, ascending: true),
            NSSortDescriptor(key: UserAttributes.firstName.rawValue, ascending: true)
        ]

        self.dataSource = FetchedDataSource(entityName: User.entityName(), predicate: predicate, sortDescriptors: sortDescriptors)
        self.dataSource.didChangeContentHandler = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    override func performNetworkTask(completion: DefaultFetchCompletionHandler?) -> URLSessionTask {
        return serviceLocator().apiClient.getFriends(completion: completion)
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FriendTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
        cell.user = self.dataSource.object(at: indexPath) as? User

        return cell
    }
}
