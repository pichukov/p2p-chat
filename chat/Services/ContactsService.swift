//
//  ContactsService.swift
//  chat
//
//  Created by Alexey Pichukov on 09.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import Contacts
import SwiftAddressBook

class ContactsService {
    
    static var chatContacts: [ContactInformation] {
        get {
            return contacts.filter { $0.chatInformation != nil }
        }
    }
    
    private static var contacts: [ContactInformation] = []
    
    
    class func addContactIds(withContactIdInformationList list: [ContactIdInformation]) {
        for idInformation in list {
            for i in 0..<contacts.count {
                var isExit = false
                for j in 0..<contacts[i].phones.count {
                    if idInformation.phone == contacts[i].phones[j] {
                        contacts[i].chatInformation = idInformation
                        isExit = true
                        break
                    }
                }
                if isExit {
                    break
                }
            }
        }
    }
    
    class func contactsAccessRequest(success successBlock: @escaping () -> Void, failure failureBlock: @escaping () -> Void) {
        SwiftAddressBook.requestAccessWithCompletion({ (success, error) -> Void in
            DispatchQueue.main.async {
                if success {
                    successBlock()
                } else {
                    failureBlock()
                }
            }
        })
    }
    
    class func phones() -> [String] {
        guard let people: [SwiftAddressBookPerson] = swiftAddressBook?.allPeople else  {
            assert(false, "📛 Error: ContatsService.\(#function) - can't get contacts")
            return []
        }
        var phones: [String] = []
        for person in people {
            guard let numbers = person.phoneNumbers else {
                continue
            }
            var singleUserPhones: [String] = []
            for phoneNumber in numbers {
                singleUserPhones.append(phoneNumber.value)
                phones.append(phoneNumber.value)
            }
            var singleUserName = ""
            let firstName = person.firstName ?? ""
            let lastName = person.lastName ?? ""
            if firstName.isEmpty {
                if lastName.isEmpty {
                    singleUserName = person.nickname ?? ""
                } else {
                    singleUserName = lastName
                }
            } else {
                singleUserName = firstName
                if lastName.count > 0 {
                    singleUserName += " " + lastName
                }
            }
            contacts.append(ContactInformation(name: singleUserName, phones: singleUserPhones, chatInformation: nil, hasRequest: false))
        }
        return phones
    }
}
