//
//  ChatStateView.swift
//  chat
//
//  Created by Alexey Pichukov on 13/12/2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import UIKit

class ChatStateView: UIView {

    weak var chatStateDelegate: ChatStateActionDelegate?
    
    class func instanceFromNib(withDelegate delegate: ChatStateActionDelegate) -> ChatStateView {
        let chatStateView = Bundle.main.loadNibNamed(ViewIdTypes.chatState.rawValue, owner: nil, options: nil)?.first as! ChatStateView
        chatStateView.chatStateDelegate = delegate
        return chatStateView
    }
    
    @IBAction func cancelChatRequest(_ sender: Any) {
        chatStateDelegate!.cancelChatRequest()
    }
}
