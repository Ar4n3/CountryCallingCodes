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

NSString *const kCountryCodesNameKey = @"name";
NSString *const kCountryCodesCodeKey = @"code";

@interface CountryCodeDataModel (Testing)
@property (strong, nonatomic) NSDictionary *jsonDict;
@property (strong, nonatomic) NSArray *filteredArray;
- (NSDictionary *)getDictionaryWithNameAndCodeForKey:(NSString *)key inDictionary:(NSDictionary *)countryCodeDict;
- (NSString *)getFormattedCallingCodeWith:(NSString *)callingCode;
- (NSDictionary *)getJSONDictionaryOrError:(NSError **)error;
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

- (void)testDictionaryWithJSONNotNil {
    CountryCodeDataModel *dataModel = [[CountryCodeDataModel alloc] init];
    NSError *error;
    NSDictionary *JSONDictionary = [dataModel getJSONDictionaryOrError:&error];
    
    XCTAssertNotNil(JSONDictionary);
}

- (void)testDictionaryWithNameAndCodeNotNil {
    CountryCodeDataModel *dataModel = [[CountryCodeDataModel alloc] init];
    NSError *error;
    NSDictionary *JSONDictionary = [dataModel getJSONDictionaryOrError:&error];
    NSDictionary *dataDictionary = [dataModel getDictionaryWithNameAndCodeForKey:@"ES" inDictionary:JSONDictionary];
    
    XCTAssertNotNil(dataDictionary);
}

- (void)testDictionaryWithNameAndCodeIsEqualName {
    CountryCodeDataModel *dataModel = [[CountryCodeDataModel alloc] init];
    NSError *error;
    NSDictionary *JSONDictionary = [dataModel getJSONDictionaryOrError:&error];
    NSDictionary *dataDictionary = [dataModel getDictionaryWithNameAndCodeForKey:@"ES" inDictionary:JSONDictionary];
    
    XCTAssertTrue([[dataDictionary objectForKey:kCountryCodesNameKey] isEqualToString:[[NSLocale currentLocale] localizedStringForCountryCode:@"ES"]]);
}

- (void)testDictionaryWithNameAndCodeIsEqualCode {
    CountryCodeDataModel *dataModel = [[CountryCodeDataModel alloc] init];
    NSError *error;
    NSDictionary *JSONDictionary = [dataModel getJSONDictionaryOrError:&error];
    NSDictionary *dataDictionary = [dataModel getDictionaryWithNameAndCodeForKey:@"ES" inDictionary:JSONDictionary];
    
    XCTAssertTrue([[dataDictionary objectForKey:kCountryCodesCodeKey] isEqualToString:@"+34"]);
}

- (void)testFormattingCallingCodeAddsPlusSign {
    CountryCodeDataModel *dataModel = [[CountryCodeDataModel alloc] init];
    NSString *code = @"34";
    
    XCTAssertTrue([[dataModel getFormattedCallingCodeWith:code] isEqualToString:@"+34"]);
}

- (void)testFormattingCallingCodeRemovesAndGetsFirstOption {
    CountryCodeDataModel *dataModel = [[CountryCodeDataModel alloc] init];
    NSString *code = @"34 and 45";
    
    XCTAssertTrue([[dataModel getFormattedCallingCodeWith:code] isEqualToString:@"+34"]);
}

- (void)testCountryCodesJSONIsNotNil {
    CountryCodeDataModel *dataModel = [[CountryCodeDataModel alloc] init];
    
    XCTAssertNotNil(dataModel.jsonDict);
}

- (void)testSearchTextFiltersJSON {
    CountryCodeDataModel *dataModel = [[CountryCodeDataModel alloc] init];
    CountryCodeDataModel *filteredDataModel = [[CountryCodeDataModel alloc] initWithSearchText:@"es"];
    XCTAssertTrue(dataModel.jsonDict.count > filteredDataModel.filteredArray.count);
}

- (void)testFilteredDataContainstSearchText {
    NSString *searchText = @"es";
    CountryCodeDataModel *filteredDataModel = [[CountryCodeDataModel alloc] initWithSearchText:searchText];
    __block BOOL containsString = YES;
    for (NSDictionary *results in filteredDataModel.filteredArray) {
        [results enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSDictionary *data = (NSDictionary *)obj;
            NSString *countryName = [data objectForKey:@"name"];
            if (![countryName localizedStandardContainsString:searchText]) {
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
