//
//  ErrorShowable.swift
//  chat
//
//  Created by Alexey Pichukov on 05.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

protocol ErrorShowable {
    func showError(_ error: NetworkCoreError)
}
