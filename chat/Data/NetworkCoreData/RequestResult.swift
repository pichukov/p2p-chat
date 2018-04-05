//
//  RequestResult.swift
//  chat
//
//  Created by Alexey Pichukov on 04.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

class RequestResult {
    
    let error: NetworkCoreError
    let data: String
    
    init?(cwRequestResult: CWRequestResult?) {
        guard cwRequestResult != nil else {
            return nil
        }
        error = NetworkCoreError(type: cwRequestResult!.error)
        data = cwRequestResult!.data
    }
}
