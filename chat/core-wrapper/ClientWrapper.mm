//
//  ClientWrapper.m
//  chat
//
//  Created by Alexey Pichukov on 29.10.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClientWrapper.h"
#import "p2p_client.h"
#include <iostream>

@implementation ClientWrapper {
    std::shared_ptr<p2p::client> _client;
}

- (id)init {
    if (self = [super init]) {
        _client = p2p::client::create();
    }
    return self;
}

- (CWRequestResult*)connectWithAddress: (NSString*)address andPort: (uint16_t)port {
    p2p::request_result request_result = _client->connect_to_server(std::string([address UTF8String]), port);
    return [[CWRequestResult alloc] initWithError: static_cast<CWError>(request_result.error()) andData: [NSString stringWithUTF8String: request_result.data().c_str()]];
}

- (CWRequestResult*)signupWithPhone: (NSString*)phone andPassword: (NSString*)password {
    p2p::request_result request_result = _client->signup(std::string([phone UTF8String]), std::string([password UTF8String]));
    return [[CWRequestResult alloc] initWithError: static_cast<CWError>(request_result.error()) andData: [NSString stringWithUTF8String: request_result.data().c_str()]];
}

- (CWRequestResult*)loginWithPhone: (NSString*)phone andPassword: (NSString*)password {
    p2p::request_result request_result = _client->login(std::string([phone UTF8String]), std::string([password UTF8String]));
    return [[CWRequestResult alloc] initWithError: static_cast<CWError>(request_result.error()) andData: [NSString stringWithUTF8String: request_result.data().c_str()]];
}

- (CWRequestResult*)getContactsWithPhones: (NSArray*)phones {
    p2p::client::phones_list _phones;
    for (NSString *element in phones) {
        _phones.push_back(std::string([element UTF8String]));
    }
    p2p::request_result request_result = _client->get_contacts(_phones);
    return [[CWRequestResult alloc] initWithError: static_cast<CWError>(request_result.error()) andData: [NSString stringWithUTF8String: request_result.data().c_str()]];
}

@end
