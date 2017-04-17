//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import UIKit
import CoreData

let UserFeedBasicViewControllerMinimumHeight = CGFloat(50)

class UserFeedBasicViewController<T: NSManagedObject>: UIViewController, UserFeedChildController, UITableViewDataSource, UITableViewDelegate {

    var didChangeContentHeightHandler: ((CGFloat) -> Void)?

    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!

    var dataSource: FetchedDataSource<T>!

    // MARK: UserFeedChildController
    func contentHeight() -> CGFloat {
        return 0
    }

    fileprivate var networkTask: URLSessionTask?

    deinit {
        self.networkTask?.cancel()

        self.tableView.removeObserver(self, forKeyPath: #keyPath(UITableView.contentSize))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTableView()
        self.setupDataSource()
        self.loadData()
    }

    fileprivate func loadData() {
        if self.dataSource.totalObjectsCount() > 0 {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
        } else {
            self.loadingIndicator.isHidden = false
            self.loadingIndicator.startAnimating()
        }

        self.networkTask?.cancel()
        self.networkTask = self.performNetworkTask() { [weak self] _, error in
            self?.loadingIndicator.stopAnimating()
            self?.loadingIndicator.isHidden = true

            self?.networkTask = nil
            self?.performContentHeightUpdates()

            if let error = error {
                let alertController = AlertsFactory.errorAlertController(withErrorMessage: error.localizedDescription)
                self?.present(alertController, animated: true)
            }
        }

        self.performContentHeightUpdates()
    }

    func setupDataSource() {
        fatalError("Should be implemented in inherited class")
    }

    func performNetworkTask(completion: DefaultFetchCompletionHandler?) -> URLSessionTask {
        fatalError("Should be implemented in inherited class")
    }

    fileprivate func configureTableView() {
        self.tableView.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: [.initial, .new], context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UITableView.contentSize) {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(performContentHeightUpdates), object: nil)

            weak var this = self
            this?.perform(#selector(performContentHeightUpdates), with: nil, afterDelay: 0.5)
        }
    }

    @objc func performContentHeightUpdates() {
        var contentHeight = CGFloat(0)
        if self.dataSource.totalObjectsCount() > 0 {
            contentHeight = self.tableView.contentSize.height
        } else if self.networkTask != nil {
            contentHeight = UserFeedBasicViewControllerMinimumHeight
        }

        self.didChangeContentHeightHandler?(contentHeight)
    }

    // MARK: UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.numberOfSections()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.numberOfRows(inSection: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Should be implemented by inherited class")
    }

    // MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}