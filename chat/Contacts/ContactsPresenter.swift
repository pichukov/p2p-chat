//
//  ContactsPresenter.swift
//  chat
//
//  Created by Alexey Pichukov on 19.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

class ContactsPresenter {
    
    private weak var viewDelegate: ContactsViewDelegate?
    private var currentSelectedContact: ContactInformation?
    
    init(withContactsViewDelegate viewDelegate: ContactsViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    func contacts() -> [ContactInformation] {
        return ContactsService.chatContacts
    }
    
    func currentContact() -> ContactInformation? {
        defer {
            currentSelectedContact = nil
        }
        return currentSelectedContact
    }
    
    func selectContact(withContactInformation contact: ContactInformation) {
        currentSelectedContact = contact
        viewDelegate?.showUserActionsActionSheet()
    }
}
