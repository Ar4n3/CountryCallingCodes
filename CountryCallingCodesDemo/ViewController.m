//
//  ViewController.m
//  CountryCallingCodesDemo
//
//  Created by Enara Lopez Otaegui on 27/6/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import "ViewController.h"
@import CountryCallingCodes;

@interface ViewController () <CountryCodesViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *countryButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
    CountryCodesViewController *ccvc = (CountryCodesViewController *)nc.topViewController;
    ccvc.delegate = self;
}


- (void)didSelectCountryWithDialCode:(NSString *)code {
    _countryButton.titleLabel.text = code;
}

@end
