//
//  LocalDataService.swift
//  chat
//
//  Created by Alexey Pichukov on 04.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

class LocalDataService {
    
    private enum LocalDataType: String {
        case userPhone
        case userPassword
    }
    
    class func userData() -> UserData? {
        guard let phone = UserDefaults.standard.object(forKey: LocalDataType.userPhone.rawValue) as? String else {
            return nil
        }
        guard let password = UserDefaults.standard.object(forKey: LocalDataType.userPassword.rawValue) as? String else {
            return nil
        }
        return UserData(phone: phone, password: password)
    }
    
    class func save(userData: UserData) {
        UserDefaults.standard.set(userData.phone, forKey: LocalDataType.userPhone.rawValue)
        UserDefaults.standard.set(userData.password, forKey: LocalDataType.userPassword.rawValue)
    }
}
