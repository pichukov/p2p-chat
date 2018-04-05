//
//  StoryboardTypes.swift
//  chat
//
//  Created by Alexey Pichukov on 04.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

enum StoryboardIdType: String {
    case registrationNavigationController = "RegistrationNavigationController"
    case loadingViewController = "LoadingViewController"
    case contactsNavigationController = "ContactsNavigationController"
}

enum StoryboardSegueType: String {
    case showChat = "ShowChatSegue"
}


enum ViewIdTypes: String {
    case chatState = "ChatStateView"
}
