//
//  CountryCodeDataModel.m
//  CountryCallingCodes
//
//  Created by Enara Lopez Otaegui on 27/6/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import "CountryCodeDataModel.h"
#import "EmojiFlag.h"

@interface CountryCodeDataModel ()
@property (strong, nonatomic) NSDictionary *jsonDict;
@property (strong, nonatomic) NSArray *filteredArray;
@end

NSString *const kCountryCodesFileName = @"countryCodes";
NSString *const kCountryCodesExtension = @"json";
NSString *const kCountryCodesSelf = @"self";
NSString *const kCountryCodesNameKey = @"name";
NSString *const kCountryCodesCodeKey = @"code";

@implementation CountryCodeDataModel

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:kCountryCodesFileName ofType:kCountryCodesExtension];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        NSError *error;
        NSDictionary *countryCodeDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if (!error) {
            NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] init];
            NSArray *sortedKeys = [[countryCodeDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
            for (NSString *key in sortedKeys) {
                NSString *countryName = [[NSLocale currentLocale] localizedStringForCountryCode:key];
                NSString *callingCode = [countryCodeDict objectForKey:key];
                if (![callingCode isEqualToString:@""]) {
                    if ([callingCode containsString:@" and "]) {
                        callingCode = [[callingCode componentsSeparatedByString:@" and "] firstObject];
                    }
                    if ([callingCode containsString:@"+"]) {
                        callingCode = [callingCode stringByReplacingOccurrencesOfString:@"+" withString:@""];
                    }
                    NSMutableString *formattedCallingCode = [[NSMutableString alloc] initWithString:@"+"];
                    [formattedCallingCode appendString:callingCode];
                    NSDictionary *helperDict = @{ kCountryCodesNameKey: countryName,
                                                  kCountryCodesCodeKey: [formattedCallingCode copy] };
                    [mutableDict setObject:helperDict forKey:(NSString *)key];
                }
            }
            _jsonDict = [mutableDict copy];
        }
    }
    
    return self;
}

- (id)initWithSearchText:(NSString *)text {
    self = [super init];
    if (self) {
        NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:kCountryCodesFileName ofType:kCountryCodesExtension];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        NSError *error;
        NSDictionary *countryCodeDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if (!error) {
            NSArray *sortedKeys = [[countryCodeDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
            NSMutableArray *helperArray = [[NSMutableArray alloc] initWithCapacity:sortedKeys.count];
            for (NSString *key in sortedKeys) {
                NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] init];
                NSString *countryName = [[NSLocale currentLocale] localizedStringForCountryCode:key];
                if ([countryName localizedCaseInsensitiveContainsString:text]) {
                    NSString *callingCode = [countryCodeDict objectForKey:key];
                    if (![callingCode isEqualToString:@""]) {
                        if ([callingCode containsString:@" and "]) {
                            callingCode = [[callingCode componentsSeparatedByString:@" and "] firstObject];
                        }
                        if ([callingCode containsString:@"+"]) {
                            callingCode = [callingCode stringByReplacingOccurrencesOfString:@"+" withString:@""];
                        }
                        NSMutableString *formattedCallingCode = [[NSMutableString alloc] initWithString:@"+"];
                        [formattedCallingCode appendString:callingCode];
                        NSDictionary *helperDict = @{ kCountryCodesNameKey: countryName,
                                                      kCountryCodesCodeKey: [formattedCallingCode copy] };
                        [mutableDict setObject:helperDict forKey:(NSString *)key];
                        [helperArray addObject:mutableDict];
                    }
                }
            }
            _filteredArray = [helperArray copy];
        }
    }
    
    return self;
}

- (NSString *)getCountryFlagForCode:(NSString *)countryCode {
    EmojiFlag *emojiFlag = [[EmojiFlag alloc] init];
    
    return [emojiFlag getEmojiForCountryCode:countryCode];
}

- (NSString *)filteredCountryNameFor:(NSIndexPath *)indexPath {
    NSDictionary *dict = [[_filteredArray objectAtIndex:indexPath.row] objectForKey:[self getCountryCodeForFilteredModelAtIndexPath:indexPath]];
    return [dict objectForKey:kCountryCodesNameKey];
}

- (NSString *)countryNameForCode:(NSString *)countryCode {
    return [[_jsonDict objectForKey:countryCode] objectForKey:kCountryCodesNameKey];
}

- (NSString *)filteredCountryDialCodeFor:(NSIndexPath *)indexPath {
    NSDictionary *dict = [[_filteredArray objectAtIndex:indexPath.row] objectForKey:[self getCountryCodeForFilteredModelAtIndexPath:indexPath]];
    return [dict objectForKey:kCountryCodesCodeKey];
}

- (NSString *)countryDialCodeForCode:(NSString *)countryCode {
    return [[_jsonDict objectForKey:countryCode] objectForKey:kCountryCodesCodeKey];
}

- (NSInteger)getNumberOfRowsInSectionForFilteredModel {
    return _filteredArray.count;
}

- (NSInteger)getNumberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = [self getSectionIndexTitles];
    NSPredicate *startingWithSection = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@", [sectionArray objectAtIndex:section]];
    NSArray *allValuesForSection = [[_jsonDict allValues] filteredArrayUsingPredicate:startingWithSection];
    return allValuesForSection.count;
}

- (NSString *)getCountryCodeForFilteredModelAtIndexPath:(NSIndexPath *)indexPath {
    return [[_filteredArray objectAtIndex:indexPath.row] allKeys][0];
}

- (NSString *)getCountryCodeAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sortedValues = [[_jsonDict allValues] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDictionary *dict1 = (NSDictionary *)obj1;
        NSDictionary *dict2 = (NSDictionary *)obj2;
        return [[dict1 objectForKey:kCountryCodesNameKey] compare:[dict2 objectForKey:kCountryCodesNameKey] options:NSCaseInsensitiveSearch];
    }];
    NSArray *sectionArray = [self getSectionIndexTitles];
    NSPredicate *startingWithSection = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@", [sectionArray objectAtIndex:indexPath.section]];
    NSArray *filteredArray = [sortedValues filteredArrayUsingPredicate:startingWithSection];
    return [_jsonDict allKeysForObject:[filteredArray objectAtIndex:indexPath.row]][0];
}

- (NSArray *)getSectionIndexTitles {
    NSArray *sortedValues = [[_jsonDict allValues] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDictionary *dict1 = (NSDictionary *)obj1;
        NSDictionary *dict2 = (NSDictionary *)obj2;
        return [[dict1 objectForKey:kCountryCodesNameKey] compare:[dict2 objectForKey:kCountryCodesNameKey] options:NSCaseInsensitiveSearch];
    }];
    NSMutableArray *helperArray = [[NSMutableArray alloc] initWithCapacity:sortedValues.count];
    for (NSDictionary *dict in sortedValues) {
        NSString *alphabetString = [[dict objectForKey:kCountryCodesNameKey] substringWithRange:NSMakeRange(0, 1)];
        if (![helperArray containsObject:alphabetString]) {
            [helperArray addObject:alphabetString];
        }
    }
    
    return [helperArray copy];
}

@end
