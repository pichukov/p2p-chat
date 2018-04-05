//
//  ContactInformation.swift
//  chat
//
//  Created by Alexey Pichukov on 11.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import Gloss

struct ContactInformation {
    let name: String
    let phones: [String]
    var chatInformation: ContactIdInformation?
    var hasRequest: Bool
}

struct ContactsObject: Gloss.Decodable {
    
    let contacts: [ContactIdInformation]
    
    init?(json: JSON) {
        guard let contacts: [ContactIdInformation] = "contacts" <~~ json else {
            return nil
        }
        self.contacts = contacts
    }
}

struct ContactIdInformation: Gloss.Decodable {
    
    let id: String
    let phone: String
    
    init?(json: JSON) {
        guard let id: String = "id" <~~ json,
              let phone: String = "phone" <~~ json
        else {
            return nil
        }
        self.id = id
        self.phone = phone
    }
}
