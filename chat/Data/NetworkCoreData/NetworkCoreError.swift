//
//  NetworkCoreError.swift
//  chat
//
//  Created by Alexey Pichukov on 04.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

enum NetworkCoreError: Error {
    case none
    case coreError
    case noContactsAccess
    case noError
    case connectionRefused
    case protocolError
    case connectionProblem
    case serverIncompatibleVersion
    case invalidData
    case phoneAlreadyRegistered
    case phoneAuthorized
    case userAuthorized
    case userNotAuthorized
    case invalidPhoneOrPassword
    case parseError
    
    init(type: CWError) {
        switch type {
        case NoError:                   self = .noError
        case ConnectionRefused:         self = .connectionRefused
        case ProtocolError:             self = .protocolError
        case ConnectionProblem:         self = .connectionProblem
        case ServerIncompatibleVersion: self = .serverIncompatibleVersion
        case InvalidData:               self = .invalidData
        case PhoneAlreadyRegistered:    self = .phoneAlreadyRegistered
        case PhoneAuthorized:           self = .phoneAuthorized
        case UserAuthorized:            self = .userAuthorized
        case UserNotAuthorized:         self = .userNotAuthorized
        case InvalidPhoneOrPassword:    self = .invalidPhoneOrPassword
        default:
            assert(false, "Error: NetworkCoreError.\(#function) - no enum item for error")
            self = .none
        }
    }
    
    func message() -> String {
        switch self {
        default: return ""
        }
    }
}
