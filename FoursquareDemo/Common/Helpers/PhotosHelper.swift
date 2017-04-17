//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation

class PhotosHelper {

    fileprivate static let possibleWidths = [36, 100, 300, 500]

    static func getAppropriatePhotoURL(photo: Photo?, size: CGSize) -> URL? {
        guard let photo = photo else { return nil}

        var appropriateWidth = Int.max
        for width in PhotosHelper.possibleWidths {
            if abs(Int(size.width) - width) < abs(Int(size.width) - appropriateWidth) {
                appropriateWidth = width
            } else {
                break
            }
        }

        let sizeString = "\(appropriateWidth)x\(appropriateWidth)"

        return URL(string: photo.prefix + sizeString + photo.suffix)
    }
}
