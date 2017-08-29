//
//  CountryCodeDataModel.h
//  CountryCallingCodes
//
//  Created by Enara Lopez Otaegui on 27/6/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CountryCodeDataModel : NSObject
- (instancetype)initWithSearchText:(NSString *)text;
- (NSString *)getCountryFlagForCode:(NSString *)countryCode;
- (NSString *)filteredCountryNameFor:(NSIndexPath *)indexPath;
- (NSString *)countryNameForCode:(NSString *)countryCode;
- (NSString *)filteredCountryDialCodeFor:(NSIndexPath *)indexPath;
- (NSString *)countryDialCodeForCode:(NSString *)countryCode;
- (NSInteger)getNumberOfRowsInSectionForFilteredModel;
- (NSInteger)getNumberOfRowsInSection:(NSInteger)section;
- (NSString *)getCountryCodeForFilteredModelAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)getCountryCodeAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)getSectionIndexTitles;
@end
