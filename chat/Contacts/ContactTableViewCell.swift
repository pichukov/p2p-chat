//
//  ContactTableViewCell.swift
//  chat
//
//  Created by Alexey Pichukov on 27.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var actionButtonsView: UIView!
    @IBOutlet weak var actionButtonsViewWidthConstraint: NSLayoutConstraint!
    
    @IBAction func confirmButtonAction(_ sender: Any) {
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func fill(withContact contactInformation: ContactInformation) {
        nameLabel.text = contactInformation.name
        phoneLabel.text = contactInformation.chatInformation?.phone
        if !contactInformation.hasRequest {
            actionButtonsView.isHidden = true
            actionButtonsViewWidthConstraint.constant = 0
        }
    }
}
