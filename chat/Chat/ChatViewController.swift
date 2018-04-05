//
//  ChatTableViewController.swift
//  chat
//
//  Created by Alexey Pichukov on 29.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import UIKit
import NMessenger
import AsyncDisplayKit

class ChatViewController: NMessengerViewController {

    fileprivate var chatPresenter: ChatPresenter?
    
    private(set) var lastMessageGroup: MessageGroup? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = chatPresenter?.contactName()
        chatPresenter?.bootstrap()
    }
    
    override func sendText(_ text: String, isIncomingMessage: Bool) -> GeneralMessengerCell {
        let textContent = TextContentNode(textMessageString: text, currentViewController: self, bubbleConfiguration: self.sharedBubbleConfiguration)
        let newMessage = MessageNode(content: textContent)
        newMessage.cellPadding = messagePadding
        newMessage.currentViewController = self
//        postText(newMessage, isIncomingMessage: false)
        return newMessage
    }
    
    private func postText(_ message: MessageNode, isIncomingMessage: Bool) {
        if self.lastMessageGroup == nil || self.lastMessageGroup?.isIncomingMessage == !isIncomingMessage {
            self.lastMessageGroup = self.createMessageGroup()
            
            self.lastMessageGroup!.isIncomingMessage = isIncomingMessage
            self.messengerView.addMessageToMessageGroup(message, messageGroup: self.lastMessageGroup!, scrollsToLastMessage: false)
            self.messengerView.addMessage(self.lastMessageGroup!, scrollsToMessage: true, withAnimation: isIncomingMessage ? .left : .right)
        } else {
            self.messengerView.addMessageToMessageGroup(message, messageGroup: self.lastMessageGroup!, scrollsToLastMessage: true)
        }
    }

    private func createMessageGroup() -> MessageGroup {
        let newMessageGroup = MessageGroup()
        newMessageGroup.currentViewController = self
        newMessageGroup.cellPadding = self.messagePadding
        return newMessageGroup
    }
}

extension ChatViewController: ChatControllerDelegate {
    
    func setContact(_ contact: ContactInformation) {
        chatPresenter = ChatPresenter(withContactInformation: contact, viewDelegate: self)
    }
}

extension ChatViewController: ChatViewDelegate {
    
    func showChatStateView() {
    }
}
