//
//  CountryCallingCodeTests.m
//  CountryCallingCodes
//
//  Created by Enara Lopez Otaegui on 29/8/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CountryCallingCode.h"

@interface CountryCallingCodeTests : XCTestCase <CountryCallingCodeDelegate>

@end

@interface CountryCallingCode (Testing)
- (void)setDelegate:(id<CountryCallingCodeDelegate>)delegate;
- (void)updateDataWith:(NSNotification *)notif;
- (void)updateDataWithCode:(NSString *)code andFlag:(NSString *)flag;
@end

@implementation CountryCallingCodeTests

- (void)setUp {
    [super setUp];
    
    [CountryCallingCode sharedInstance];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCountryCallingCodeObjectIsNotNil {
    XCTAssertNotNil([CountryCallingCode sharedInstance]);
}

- (void)testCountryCodeObjectSetsDelegateNotNil {
    [self mockDelegate];
    
    XCTAssertNotNil([CountryCallingCode sharedInstance].delegate);
}

- (void)testCountryCodeObjectUpdateDataWithNotificationNotNil {
    [self mockNotification];
    
    XCTAssertNotNil([CountryCallingCode sharedInstance].code);
    XCTAssertNotNil([CountryCallingCode sharedInstance].flag);
}

- (void)testCountryCodeObjectUpdateDataWithNotificationCodeEqualsCode {
    [self mockNotification];
    
    XCTAssertTrue([[CountryCallingCode sharedInstance].code isEqualToString:@"+34"]);
}

- (void)testCountryCodeObjectUpdateDataWithNotificationFlagEqualsFlag {
    [self mockNotification];
    
    XCTAssertTrue([[CountryCallingCode sharedInstance].flag isEqualToString:@"🇪🇸"]);
}

- (void)mockNotification {
    NSNotification *notif = [[NSNotification alloc] initWithName:kDidSelectCountryCode object:nil userInfo:@{ kCCCode: @"+34", kCCFlag: @"🇪🇸" }];
    [[NSNotificationCenter defaultCenter] postNotification:notif];
}

- (void)mockDelegate {
    id<CountryCallingCodeDelegate>delegate = self;
    [CountryCallingCode sharedInstance].delegate = self;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
