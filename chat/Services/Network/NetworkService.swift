//
//  NetworkService.swift
//  chat
//
//  Created by Alexey Pichukov on 04.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import Gloss

class NetworkService {
    
    static let shared = NetworkService()
    
    internal var isConnect = false
    internal var connectInProcess = false
    fileprivate let clientWrapper: ClientWrapper
    fileprivate enum ServerData {
        static let address = "127.0.0.1"
        static let port: UInt16 = 12345
    }
    fileprivate struct RequestData {
        
        typealias T = Any
        
        let enterData: T
        let execFunc: (_ enterData: T) -> CWRequestResult?
        let successBlock: (_ data: Gloss.Decodable) -> Void
        let failureBlock: (_ error: NetworkCoreError) -> Void
    }
    fileprivate var requestsToRepeat: [RequestData] = []
    
    init() {
        clientWrapper = ClientWrapper()
    }
}

extension NetworkService: Requestable {
    
    func syncConnect() {
        connectInProcess = true
        let requestResult = RequestResult(cwRequestResult: self.clientWrapper.connect(withAddress: ServerData.address, andPort: ServerData.port))
        if requestResult != nil {
            guard requestResult!.error == .noError else {
                self.isConnect = false
                self.connectInProcess = false
                return
            }
            self.isConnect = true
            self.connectInProcess = false
        } else {
            self.isConnect = false
            self.connectInProcess = false
        }
    }
    
    // MARK: Request methods
    
    func signup(withUserData userData: UserData, success successBlock: @escaping (_ data: EmptyObject) -> Void, failure failureBlock: @escaping (_ error: NetworkCoreError) -> Void) {
        syncRequest(withEnterData: userData, functionForExecute: coreSignup, success: successBlock, failure: failureBlock)
    }
    
    func login(withUserData userData: UserData, success successBlock: @escaping (_ data: EmptyObject) -> Void, failure failureBlock: @escaping (_ error: NetworkCoreError) -> Void) {
        syncRequest(withEnterData: userData, functionForExecute: coreLogin, success: successBlock, failure: failureBlock)
    }
    
    func contacts(withPhones phones: [String], success successBlock: @escaping (_ data: ContactsObject) -> Void, failure failureBlock: @escaping (_ error: NetworkCoreError) -> Void) {
        syncRequest(withEnterData: phones, functionForExecute: coreContacts, success: successBlock, failure: failureBlock)
    }
    
    // MARK: Core methods
    
    private func coreSignup(_ enterData: UserData) -> CWRequestResult? {
        return self.clientWrapper.signup(withPhone: enterData.phone, andPassword: enterData.password)
    }
    
    private func coreLogin(_ enterData: UserData) -> CWRequestResult? {
        return self.clientWrapper.login(withPhone: enterData.phone, andPassword: enterData.password)
    }
    
    private func coreContacts(_ enterData: [String]) -> CWRequestResult? {
        return self.clientWrapper.getContactsWithPhones(enterData)
    }
}
