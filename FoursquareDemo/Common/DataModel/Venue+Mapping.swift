//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import FastEasyMapping

extension Venue {

    static func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: Venue.entityName())

        mapping.primaryKey = VenueAttributes.identifier.rawValue

        mapping.addAttributes(from: [
                VenueAttributes.identifier.rawValue: "id",
                VenueAttributes.name.rawValue: "name"
        ])

        return mapping
    }
}
