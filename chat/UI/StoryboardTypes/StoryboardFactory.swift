//
//  StoryboardFactory.swift
//  chat
//
//  Created by Alexey Pichukov on 04.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import UIKit

class StoryboardFactory {
    
    private static let storyboardName = "Main"
    
    class func registrationNavigationController() -> UINavigationController {
        guard let controller = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: StoryboardIdType.registrationNavigationController.rawValue) as? UINavigationController else {
            assert(false, "Error: StoryboardFactory.\(#function) - storyboard have no UINavigationController with current ID")
            return UINavigationController()
        }
        return controller
    }
    
    class func contactsNavigationController() -> UINavigationController {
        guard let controller = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: StoryboardIdType.contactsNavigationController.rawValue) as? UINavigationController else {
            assert(false, "Error: StoryboardFactory.\(#function) - storyboard have no UINavigationController with current ID")
            return UINavigationController()
        }
        return controller
    }
    
    class func loadingViewController() -> UIViewController {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: StoryboardIdType.loadingViewController.rawValue)
    }
}
