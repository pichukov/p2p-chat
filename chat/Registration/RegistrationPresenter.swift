//
//  RegistrationPresenter.swift
//  chat
//
//  Created by Alexey Pichukov on 04.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

class RegistrationPresenter {
    
    private weak var viewDelegate: RegistrationViewDelegate?
    private weak var registrationCompleteDelegate: RegistrationCompletable?
    
    init(withRegistrationViewDelegate viewDelegate: RegistrationViewDelegate, registrationCompleteDelegate: RegistrationCompletable?) {
        self.viewDelegate = viewDelegate
        self.registrationCompleteDelegate = registrationCompleteDelegate
    }
    
    func signup(withUserData userData: UserData) {
        viewDelegate?.showLoading()
        NetworkService.shared.signup(withUserData: userData, success: { [unowned self] _ in
            LocalDataService.save(userData: userData)
            self.viewDelegate?.hideLoading()
            self.registrationCompleteDelegate?.registrationComplete()
        }) { [unowned self] (error) in
            self.viewDelegate?.hideLoading()
            self.viewDelegate?.showError(error)
        }
    }
}
