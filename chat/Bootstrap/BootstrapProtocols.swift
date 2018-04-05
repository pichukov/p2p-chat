//
//  BootstrapProtocols.swift
//  chat
//
//  Created by Alexey Pichukov on 04.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

protocol BootstrapViewDelegate: class, ErrorAndLoadingShowable {
    func showRegistration()
    func hideRegistration(withCompletion completionBlock: @escaping () -> Void)
    func showChat()
}
