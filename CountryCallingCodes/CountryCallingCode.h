//
//  CountryCallingCode.h
//  CountryCallingCodes
//
//  Created by Enara Lopez Otaegui on 22/8/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

@protocol CountryCallingCodeDelegate <NSObject>
///---------------------------
/// @name Update Country Data
///---------------------------

/**
 Tells de delegate there is new data to update.

 */
- (void)updateCountryData;
@end

/**
 `CountryCallingCode` is a singleton class with convenience methods for getting the calling code and Emoji flag of a selected country.
 
 ## Demos
 For more information on how to use this simple library see the demos at:
 
 ## Delegation
 
 @warning It is important to set the delegate before you access the given UI for the selection of the country to get the default Calling code and flag based on the device Locale.
 */

@interface CountryCallingCode : NSObject
/**
 The delegate will receive messages when updating data is needed.
 */
@property (weak, nonatomic) id<CountryCallingCodeDelegate>delegate;
/**
 The international calling code for the selected country.
 */
@property (readonly, nonatomic) NSString *code;
/**
 The emoji flag for the selected country.
 */
@property (readonly, nonatomic) NSString *flag;

+ (instancetype)sharedInstance;

@end
