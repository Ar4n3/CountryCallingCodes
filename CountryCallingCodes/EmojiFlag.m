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

- (UIImage *)getEmojiForCountryCode:(NSString *)countryCode {
    NSNumber * y = _jsonDict[countryCode];
    if (!y) {
        y = @0;
    }
    CGImageRef cgImage = CGImageCreateWithImageInRect([[UIImage imageWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"flags" ofType:@"png"]] CGImage], CGRectMake(0, y.integerValue * 2, 32, 32));
    UIImage * result = [UIImage imageWithCGImage:cgImage scale:2.0 orientation:UIImageOrientationUp];
    CGImageRelease(cgImage);
    return result;
}

@end
