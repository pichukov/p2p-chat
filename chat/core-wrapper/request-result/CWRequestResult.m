//
//  CWRequestResult.m
//  chat
//
//  Created by Alexey Pichukov on 31.10.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWRequestResult.h"

@implementation CWRequestResult

@synthesize error = _error;
@synthesize data = _data;

- (id)init {
    return [self initWithError: NoError andData: nil];
}

- (id)initWithError:(enum CWError)error andData:(NSString *)data {
    if (self = [super init]) {
        _error = error;
        _data = data;
    }
    return self;
}

@end
