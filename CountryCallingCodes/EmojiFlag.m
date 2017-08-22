//
//  EmojiFlag.m
//  CountryCallingCodes
//
//  Created by Enara Lopez Otaegui on 27/6/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import "EmojiFlag.h"
#import <CoreGraphics/CoreGraphics.h>

@interface EmojiFlag ()
@property (strong, nonatomic) NSDictionary *jsonDict;
@end

@implementation EmojiFlag

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"flag_indices" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        _jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    }
    
    return self;
}

- (NSString *)getEmojiForCountryCode:(NSString *)countryCode {
    return [_jsonDict objectForKey:countryCode];
}

@end
