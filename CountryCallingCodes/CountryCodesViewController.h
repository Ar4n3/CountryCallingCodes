//
//  CountryCodesViewController.h
//  CountryCallingCodes
//
//  Created by Enara Lopez Otaegui on 27/6/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountryCodesViewControllerDelegate <NSObject>
- (void)didSelectCountryWithDialCode:(NSString *)code;
@end

@interface CountryCodesViewController : UIViewController
@property (weak, nonatomic) id<CountryCodesViewControllerDelegate>delegate;
@end
