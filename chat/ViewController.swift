//
//  ViewController.swift
//  chat
//
//  Created by Alexey Pichukov on 29.10.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import UIKit

class ViewController: LoadingViewController {

    fileprivate var bootstrapPresenter: BootstrapPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bootstrap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func bootstrap() {
        bootstrapPresenter = BootstrapPresenter(withBootstrapViewDelegate: self)
    }
}

extension ViewController: BootstrapViewDelegate {
    
    func showError(_ error: NetworkCoreError) {
        print("🔴 Error from CORE = \(error)")
    }
    
    func showRegistration() {
        DispatchQueue.main.async { [unowned self] in
            let registrationNavigationController = StoryboardFactory.registrationNavigationController()
            guard let registrationCompleteSetable = registrationNavigationController.childViewControllers.first as? RegistrationCompleteSetable else {
                assert(false, "📛 Error: ViewController.\(#function) - object is not confirm to RegistrationCompleteSetable protocol")
                return
            }
            registrationCompleteSetable.set(registrationCompleteDelegate: self.bootstrapPresenter)
            self.navigationController?.present(registrationNavigationController, animated: true, completion: nil)
        }
    }
    
    func hideRegistration(withCompletion completionBlock: @escaping () -> Void) {
        self.dismiss(animated: true, completion: completionBlock)
    }
    
    func showChat() {
        print("⚪️ GO to CHAT")
        
    }
}
