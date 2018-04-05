//
//  ContactsTableViewController.swift
//  chat
//
//  Created by Alexey Pichukov on 19.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import UIKit

class ContactsTableViewController: LoadingTableViewController {

    fileprivate var bootstrapPresenter: BootstrapPresenter?
    fileprivate var contactsPresenter: ContactsPresenter?
    fileprivate var contacts: [ContactInformation] {
        guard contactsPresenter != nil else {
            return []
        }
        return contactsPresenter!.contacts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bootstrap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func bootstrap() {
        bootstrapPresenter = BootstrapPresenter(withBootstrapViewDelegate: self)
        contactsPresenter = ContactsPresenter(withContactsViewDelegate: self)
    }
}

extension ContactsTableViewController: BootstrapViewDelegate {
    
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
        tableView.reloadData()
    }
}

// MARK: - Table view data source
extension ContactsTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellType.contact.rawValue) as? ContactTableViewCell else {
            assert(false, "Error: ContactsTableViewController.\(#function) - no cell with id")
        }
        cell.fill(withContact: contacts[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        contactsPresenter?.selectContact(withContactInformation: contacts[indexPath.row])
    }
}

// MARK: - ContactsViewProtocol
extension ContactsTableViewController: ContactsViewDelegate {
    
    func showUserActionsActionSheet() {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let chatRequest = UIAlertAction(title: "Chat Request", style: .default) { [unowned self] _ -> Void in
            self.performSegue(withIdentifier: StoryboardSegueType.showChat.rawValue, sender: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        actionSheetController.addAction(chatRequest)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
    }
}

// MARK: - Work with segues
extension ContactsTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == StoryboardSegueType.showChat.rawValue, let chatViewController = segue.destination as? ChatControllerDelegate else {
            assert(false, "Error: ContactsTableViewController.\(#function) - wrong segue or segue data")
            return
        }
        guard let contact = contactsPresenter?.currentContact() else {
            assert(false, "Error: ContactsTableViewController.\(#function) - no current selected contact")
            return
        }
        chatViewController.setContact(contact)
    }
    
}
