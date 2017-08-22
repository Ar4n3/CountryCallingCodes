//
//  CountryCallingCode.m
//  CountryCallingCodes
//
//  Created by Enara Lopez Otaegui on 22/8/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import "CountryCallingCode.h"
#import "CallingCodeHelper.h"

@implementation CountryCallingCode

+ (instancetype)sharedInstance {
    static CountryCallingCode *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CountryCallingCode alloc] init];
    });
    return sharedInstance;
}

- (void)setDelegate:(id<CountryCallingCodeDelegate>)delegate {
    _delegate = delegate;
    _code = [CallingCodeHelper defaultCallingCode];
    _flag = [CallingCodeHelper defaultCountryFlag];
}

- (void)updateDataWithCode:(NSString *)code andFlag:(NSString *)flag {
    _code = (code) ? code : _code;
    _flag = (flag) ? flag : _flag;
}
    
@end
