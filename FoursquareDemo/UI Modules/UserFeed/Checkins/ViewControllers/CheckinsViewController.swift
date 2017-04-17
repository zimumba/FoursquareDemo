//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import UIKit

class CheckinsViewController: UserFeedBasicViewController<Checkin> {

    override func setupDataSource() {
        guard let currentUser = User.currentUser() else { fatalError("Unexpected current user is empty") }

        let predicate = NSPredicate(format: "%K == %@", CheckinRelationships.user.rawValue, currentUser)
        let sortDescriptors = [
                NSSortDescriptor(key: CheckinAttributes.createdAt.rawValue, ascending: true),
        ]

        self.dataSource = FetchedDataSource(entityName: Checkin.entityName(), predicate: predicate, sortDescriptors: sortDescriptors)
    }

    override func performNetworkTask(completion: DefaultFetchCompletionHandler?) -> URLSessionTask {
        return serviceLocator().apiClient.getCheckins(completion: completion)
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CheckinTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
        cell.checkin = self.dataSource.object(at: indexPath)

        return cell
    }
}
