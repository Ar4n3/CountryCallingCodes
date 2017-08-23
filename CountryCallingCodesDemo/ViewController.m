//
//  ViewController.m
//  CountryCallingCodesDemo
//
//  Created by Enara Lopez Otaegui on 27/6/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CountryCallingCodeDelegate>
@property (weak, nonatomic) IBOutlet UIButton *countryButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[CountryCallingCode sharedInstance] setDelegate:self];
    NSString *buttonString = [NSString stringWithFormat:@"%@\t%@", [CountryCallingCode sharedInstance].flag, [CountryCallingCode sharedInstance].code];
    [_countryButton setTitle:buttonString forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Methods

- (void)updateCountryData {
    NSString *buttonString = [NSString stringWithFormat:@"%@\t%@", [CountryCallingCode sharedInstance].flag, [CountryCallingCode sharedInstance].code];
    [_countryButton setTitle:buttonString forState:UIControlStateNormal];
}

@end
