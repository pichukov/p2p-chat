//
//  RegistrationViewController.swift
//  chat
//
//  Created by Alexey Pichukov on 04.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import UIKit

class RegistrationViewController: LoadingViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    fileprivate weak var registrationCompleteDelegate: RegistrationCompletable?
    
    private var registrationPresenter: RegistrationPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func initPresenter() {
        registrationPresenter = RegistrationPresenter(withRegistrationViewDelegate: self, registrationCompleteDelegate: registrationCompleteDelegate)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        guard let phone = phoneTextField.text, let password = passwordTextField.text else {
            assert(false, "📛 Error: RegistrationViewController.\(#function) - phone or password is nil")
            return
        }
        registrationPresenter?.signup(withUserData: UserData(phone: phone, password: password))
    }
}

extension RegistrationViewController: RegistrationCompleteSetable {
    func set(registrationCompleteDelegate: RegistrationCompletable?) {
        self.registrationCompleteDelegate = registrationCompleteDelegate
    }
}

extension RegistrationViewController: RegistrationViewDelegate {
    
    func showError(_ error: NetworkCoreError) {
        print("🔴 Error from CORE = \(error)")
    }
}
