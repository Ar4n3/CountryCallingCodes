//
//  CountryCallingCode.h
//  CountryCallingCodes
//
//  Created by Enara Lopez Otaegui on 22/8/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CountryCallingCodeDelegate <NSObject>
- (void)updateCountryData;
@end

@interface CountryCallingCode : NSObject
@property (weak, nonatomic) id<CountryCallingCodeDelegate>delegate;
@property (readonly, nonatomic) NSString *code;
@property (readonly, nonatomic) NSString *flag;

extern NSString *const kCCCode;
extern NSString *const kCCFlag;
extern NSString *const kDidSelectCountryCode;

+ (instancetype)sharedInstance;
@end
