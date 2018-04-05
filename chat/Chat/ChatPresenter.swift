//
//  ChatPresenter.swift
//  chat
//
//  Created by Alexey Pichukov on 13/12/2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

class ChatPresenter {
    
    private weak var viewDelegate: ChatViewDelegate?
    private let contact: ContactInformation
    
    init(withContactInformation contact: ContactInformation, viewDelegate: ChatViewDelegate) {
        self.contact = contact
        self.viewDelegate = viewDelegate
    }
    
    func bootstrap() {
        viewDelegate?.showChatStateView()
    }
    
    func contactName() -> String {
        return contact.name
    }
}

extension ChatPresenter: ChatStateActionDelegate {
    
    func cancelChatRequest() {
        print("⚗️ Cancel")
    }
}
