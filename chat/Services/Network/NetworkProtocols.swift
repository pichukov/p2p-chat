//
//  NetworkProtocols.swift
//  chat
//
//  Created by Alexey Pichukov on 05.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import Gloss

protocol Requestable: class {
    var isConnect: Bool { get }
    var connectInProcess: Bool { get }
    func syncConnect()
}

extension Requestable {
    
    func syncRequest<T, D: Gloss.Decodable>(withEnterData enterData: T, functionForExecute execFunc: @escaping (_ enterData: T) -> CWRequestResult?, success successBlock: @escaping (_ data: D) -> Void, failure failureBlock: @escaping (_ error: NetworkCoreError) -> Void) {
        guard isConnect else {
            if !connectInProcess {
                syncConnect()
            }
            request(withEnterData: enterData, functionForExecute: execFunc, success: successBlock, failure: failureBlock)
            return
        }
        request(withEnterData: enterData, functionForExecute: execFunc, success: successBlock, failure: failureBlock)
    }
    
    func request<T, D: Gloss.Decodable>(withEnterData enterData: T, functionForExecute execFunc: @escaping (_ enterData: T) -> CWRequestResult?, success successBlock: @escaping (_ data: D) -> Void, failure failureBlock: @escaping (_ error: NetworkCoreError) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let requestResult = RequestResult(cwRequestResult: execFunc(enterData))
            print("☄️ Request - \(enterData)")
            DispatchQueue.main.async {
                if requestResult != nil {
                    guard requestResult!.error == .noError else {
                        failureBlock(requestResult!.error)
                        return
                    }
                    guard let data = requestResult!.data.data(using: .utf8) else {
                        failureBlock(.parseError)
                        return
                    }
                    do {
                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else {
                            guard let object = D(json: [:]) else {
                                failureBlock(.parseError)
                                return
                            }
                            successBlock(object)
                            return
                        }
                        guard let object = D(json: json) else {
                            failureBlock(.parseError)
                            return
                        }
                        successBlock(object)
                    } catch {
                        guard let object = D(json: [:]) else {
                            failureBlock(.parseError)
                            return
                        }
                        successBlock(object)
                        return
                    }
                } else {
                    failureBlock(.coreError)
                }
            }
        }
    }
}
