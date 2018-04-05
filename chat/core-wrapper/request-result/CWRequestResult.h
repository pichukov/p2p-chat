//
//  CWRequestResult.h
//  chat
//
//  Created by Alexey Pichukov on 31.10.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

#ifndef CWRequestResult_h
#define CWRequestResult_h

enum CWError {
    NoError,
    ConnectionRefused,
    ProtocolError,
    ConnectionProblem,
    ServerIncompatibleVersion,
    InvalidData,
    PhoneAlreadyRegistered,
    PhoneAuthorized,
    UserAuthorized,
    UserNotAuthorized,
    InvalidPhoneOrPassword
};

@interface CWRequestResult : NSObject {
    enum CWError _error;
    NSString *_data;
}

- (id)initWithError: (enum CWError)error andData: (NSString*)data;

@property (nonatomic, readonly) enum CWError error;
@property (nonatomic, readonly) NSString *data;

@end

#endif /* CWRequestResult_h */
