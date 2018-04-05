//
//  ChatProtocols.swift
//  chat
//
//  Created by Alexey Pichukov on 13/12/2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

protocol ChatControllerDelegate {
    func setContact(_ contact: ContactInformation)
}

protocol ChatViewDelegate: class {
    func showChatStateView()
}

protocol ChatStateActionDelegate: class {
    func cancelChatRequest()
}
