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
@property (weak, nonatomic) IBOutlet UIButton *flagButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[CountryCallingCode sharedInstance] setDelegate:self];
    [_countryButton setTitle:[CountryCallingCode sharedInstance].code forState:UIControlStateNormal];
    [_flagButton setTitle:[CountryCallingCode sharedInstance].flag forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Methods

- (void)updateCountryData {
    [_countryButton setTitle:[CountryCallingCode sharedInstance].code forState:UIControlStateNormal];
    [_flagButton setTitle:[CountryCallingCode sharedInstance].flag forState:UIControlStateNormal];
}

@end
