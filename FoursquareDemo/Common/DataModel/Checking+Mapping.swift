//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import FastEasyMapping

extension Checkin {

    static func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: Checkin.entityName())

        mapping.primaryKey = CheckinAttributes.identifier.rawValue

        mapping.addAttributes(from: [
                CheckinAttributes.identifier.rawValue: "id",
                CheckinAttributes.createdAt.rawValue: "createdAt"
        ])

        mapping.addRelationship(FEMRelationship(property: CheckinRelationships.venue.rawValue, keyPath: "venue", mapping: Venue.defaultMapping()))

        return mapping
    }
}
