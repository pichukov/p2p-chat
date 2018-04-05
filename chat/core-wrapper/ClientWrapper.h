//
//  ClientWrapper.h
//  chat
//
//  Created by Alexey Pichukov on 29.10.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWRequestResult.h"

#ifndef ClientWrapper_h
#define ClientWrapper_h

@interface ClientWrapper : NSObject

- (id)init;

- (CWRequestResult*)connectWithAddress: (NSString*)address andPort: (uint16_t)port;
- (CWRequestResult*)signupWithPhone: (NSString*)phone andPassword: (NSString*)password;
- (CWRequestResult*)loginWithPhone: (NSString*)phone andPassword: (NSString*)password;
- (CWRequestResult*)getContactsWithPhones: (NSArray*)phones;
@end

#endif /* ClientWrapper_h */
