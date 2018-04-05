//
//  RegistrationProtocols.swift
//  chat
//
//  Created by Alexey Pichukov on 05.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

protocol RegistrationViewDelegate: class, ErrorAndLoadingShowable {}

protocol RegistrationCompletable: class {
    func registrationComplete()
}

protocol RegistrationCompleteSetable {
    func set(registrationCompleteDelegate: RegistrationCompletable?)
}
