//
//  BootstrapPresenter.swift
//  chat
//
//  Created by Alexey Pichukov on 04.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

class BootstrapPresenter {
    
    fileprivate weak var viewDelegate: BootstrapViewDelegate?
    
    init(withBootstrapViewDelegate delegate: BootstrapViewDelegate) {
        viewDelegate = delegate
        askContacts()
    }
    
    fileprivate func bootstrap() {
        viewDelegate?.showLoading()
        guard let userData = LocalDataService.userData() else {
            viewDelegate?.hideLoading()
            viewDelegate?.showRegistration()
            return
        }
        login(withUserData: userData)
    }
    
    private func login(withUserData userData: UserData) {
        NetworkService.shared.login(withUserData: userData, success: { [unowned self] _ in
            self.viewDelegate?.hideLoading()
            self.synchronizeContacts()
        }) { [unowned self] (error) in
            self.viewDelegate?.hideLoading()
            self.viewDelegate?.showError(error)
        }
    }
    
    private func askContacts() {
        ContactsService.contactsAccessRequest(success: { [unowned self] in
            self.bootstrap()
        }) { [unowned self] in
            self.viewDelegate?.showError(.noContactsAccess)
        }
    }
    
    private func synchronizeContacts() {
        viewDelegate?.showLoading()
        let phones = ContactsService.phones()
        NetworkService.shared.contacts(withPhones: phones, success: { [unowned self] (contactsObject) in
            print("✉️ \(contactsObject.contacts)")
            ContactsService.addContactIds(withContactIdInformationList: contactsObject.contacts)
            self.viewDelegate?.hideLoading()
            self.viewDelegate?.showChat()
        }) { [unowned self] (error) in
            self.viewDelegate?.hideLoading()
            self.viewDelegate?.showError(error)
        }
    }
}

extension BootstrapPresenter: RegistrationCompletable {
    
    func registrationComplete() {
        viewDelegate?.hideRegistration() { [unowned self] in
            self.bootstrap()
        }
    }
}
