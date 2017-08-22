//
//  CallingCodeHelper.m
//  CountryCallingCodes
//
//  Created by Enara Lopez Otaegui on 22/8/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import "CallingCodeHelper.h"
#import "CountryCodeDataModel.h"
#import <UIKit/UIKit.h>

@implementation CallingCodeHelper
    
+ (NSString *)defaultCallingCode {
    CountryCodeDataModel *dataModel = [[CountryCodeDataModel alloc] init];
    
    return [dataModel countryDialCodeForCode:[[NSLocale currentLocale] countryCode]];
}
    
+ (NSString *)defaultCountryFlag {
    CountryCodeDataModel *dataModel = [[CountryCodeDataModel alloc] init];
    
    return [dataModel getCountryFlagForCode:[[NSLocale currentLocale] countryCode]];
}
    
@end
