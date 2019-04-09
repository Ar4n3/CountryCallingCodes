//
//  CCViewController.m
//  CountryCallingCodes
//
//  Created by Ar4n3 on 04/09/2019.
//  Copyright (c) 2019 Ar4n3. All rights reserved.
//

#import "CCViewController.h"

@import CountryCallingCodes;

@interface CCViewController () <CountryCallingCodeDelegate>
@property (weak, nonatomic) IBOutlet UIButton *countryButton;
@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[CountryCallingCode sharedInstance] setDelegate:self];
    NSString *buttonString = [NSString stringWithFormat:@"%@\t%@", [CountryCallingCode sharedInstance].flag, [CountryCallingCode sharedInstance].code];
    [_countryButton setTitle:buttonString forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Methods

- (void)updateCountryData {
    NSString *buttonString = [NSString stringWithFormat:@"%@\t%@", [CountryCallingCode sharedInstance].flag, [CountryCallingCode sharedInstance].code];
    [_countryButton setTitle:buttonString forState:UIControlStateNormal];
}

@end
