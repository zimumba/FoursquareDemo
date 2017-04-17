//
// Created by Antonyo on 4/17/17.
// Copyright (c) 2017 aoli. All rights reserved.
//

import Foundation
import FastEasyMapping

extension User {

    static func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: User.entityName())

        mapping.primaryKey = UserAttributes.identifier.rawValue

        mapping.addAttributes(from: [
                UserAttributes.identifier.rawValue: "id",
                UserAttributes.firstName.rawValue: "firstName",
                UserAttributes.lastName.rawValue: "lastName",
                UserAttributes.gender.rawValue: "gender"
        ])

        mapping.addRelationship(FEMRelationship(property: UserRelationships.photo.rawValue, keyPath: "photo", mapping: Photo.defaultMapping()))

        return mapping
    }
}
