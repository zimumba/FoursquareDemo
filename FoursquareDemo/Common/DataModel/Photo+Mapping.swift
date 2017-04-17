//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import FastEasyMapping

extension Photo {

    static func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: Photo.entityName())

        mapping.primaryKey = PhotoAttributes.suffix.rawValue

        mapping.addAttributes(from: [
                PhotoAttributes.prefix.rawValue: "prefix",
                PhotoAttributes.suffix.rawValue: "suffix"
        ])

        return mapping
    }
}