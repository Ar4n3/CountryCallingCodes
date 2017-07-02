//
//  EmojiFlag.h
//  CountryCallingCodes
//
//  Created by Enara Lopez Otaegui on 27/6/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EmojiFlag : NSObject
- (UIImage *)getEmojiForCountryCode:(NSString *)countryCode;
@end
