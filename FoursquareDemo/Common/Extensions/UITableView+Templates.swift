//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import UIKit

extension UITableView {

    // Cell
    func registerCellClass<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: String(describing: type))
    }

    func registerCellNibClass<T: UITableViewCell>(_ type: T.Type) {
        let nib = UINib(nibName: String(describing: type), bundle: Bundle(for: T.self))
        register(nib, forCellReuseIdentifier: String(describing: type))
    }

    func dequeueCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }

    // Header/Footer
    func registerHeaderFooterClass<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        register(type, forHeaderFooterViewReuseIdentifier: String(describing: type))
    }

    func registerHeaderFooterNibClass<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        let nib = UINib(nibName: String(describing: type), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: type))
    }

    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as! T
    }
}
