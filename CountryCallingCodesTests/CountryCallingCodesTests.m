//
//  CountryCallingCodesTests.m
//  CountryCallingCodes
//
//  Created by Enara Lopez Otaegui on 23/8/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CountryCodeDataModel.h"

@interface CountryCallingCodesTests : XCTestCase

@end

@interface CountryCodeDataModel (Testing)
@property (strong, nonatomic) NSDictionary *jsonDict;
@property (strong, nonatomic) NSArray *filteredArray;
@end

@implementation CountryCallingCodesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCountryCodesJSONIsNotNil {
    CountryCodeDataModel *dataModel = [[CountryCodeDataModel alloc] init];
    XCTAssertNotNil(dataModel.jsonDict);
}

- (void)testSearchTextFiltersJSON {
    CountryCodeDataModel *dataModel = [[CountryCodeDataModel alloc] init];
    CountryCodeDataModel *filteredDataModel = [[CountryCodeDataModel alloc] initWithSearchText:@"e"];
    XCTAssertTrue(dataModel.jsonDict.count >= filteredDataModel.filteredArray.count);
}

- (void)testFilteredDataContainstSearchText {
    NSString *searchText = @"es";
    CountryCodeDataModel *filteredDataModel = [[CountryCodeDataModel alloc] initWithSearchText:searchText];
    __block BOOL containsString = YES;
    for (NSDictionary *results in filteredDataModel.filteredArray) {
        [results enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSDictionary *data = (NSDictionary *)obj;
            NSString *countryName = [data objectForKey:@"name"];
            if (![countryName localizedCaseInsensitiveContainsString:searchText]) {
                containsString = NO;
            }
        }];
    }
    XCTAssertTrue(containsString);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
