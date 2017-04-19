//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import UIKit

extension UIImage {

    static func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        var imageWithColor: UIImage

        let rect = CGRect(origin: CGPoint.zero, size: size)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        // COMM: force unwrapping is a risky operation
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        // COMM: force unwrapping is a risky operation
        imageWithColor = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return imageWithColor
    }
}
