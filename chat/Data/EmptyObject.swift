//
//  EmptyObject.swift
//  chat
//
//  Created by Alexey Pichukov on 11.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import Gloss

struct EmptyObject: Gloss.Decodable {
    
    init?(json: JSON) {}
}
