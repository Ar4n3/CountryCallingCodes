//
//  CountryCodesViewController.m
//  CountryCallingCodes
//
//  Created by Enara Lopez Otaegui on 27/6/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

#import "CountryCodesViewController.h"
#import "CountryCodeDataModel.h"
#import "CountryCallingCode.h"

@interface CountryCodesViewController () <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CountryCodeDataModel *dataModel;
@property (strong, nonatomic) CountryCodeDataModel *filteredDataModel;
@property (strong, nonatomic) CountryCallingCode *countryCallingManager;
@property (strong, nonatomic) NSArray *sectionIndexTitles;
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation CountryCodesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataModel = [[CountryCodeDataModel alloc] init];
    [self configureSearchController];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _sectionIndexTitles = [_dataModel getSectionIndexTitles];
    [_tableView reloadData];
}
    
- (void)dealloc {
    [_searchController.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search Controller Delegate

- (void)configureSearchController {
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = false;
    _searchController.definesPresentationContext = true;
    _tableView.tableHeaderView = _searchController.searchBar;
    [_tableView setContentOffset:CGPointMake(0, _searchController.searchBar.frame.size.height) animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    _filteredDataModel = [[CountryCodeDataModel alloc] initWithSearchText:searchController.searchBar.text];
    [_tableView reloadData];
}

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_searchController.isActive && ![_searchController.searchBar.text isEqualToString:@""]) {
        return 1;
    }
    return _sectionIndexTitles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_searchController.isActive && ![_searchController.searchBar.text isEqualToString:@""]) {
        return nil;
    }
    return [_sectionIndexTitles objectAtIndex:section];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (_searchController.isActive && ![_searchController.searchBar.text isEqualToString:@""]) {
        return nil;
    }
    return _sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (_searchController.isActive && ![_searchController.searchBar.text isEqualToString:@""]) {
        return 0;
    }
    return [_sectionIndexTitles indexOfObject:title];
}

- (NSUInteger)countOfSectionIndexTitles {
    if (_searchController.isActive && ![_searchController.searchBar.text isEqualToString:@""]) {
        return 0;
    }
    return _sectionIndexTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchController.isActive && ![_searchController.searchBar.text isEqualToString:@""]) {
        return [_filteredDataModel getNumberOfRowsInSectionForFilteredModel];
    }
    return [_dataModel getNumberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountryCodeCell" forIndexPath:indexPath];
    NSString *code = [self getCallingCodeForIndexPath:indexPath];
    NSString *flag = [self getFlagForIndexPath:indexPath];
    NSString *countryName = [self getCountryNameForIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@\t%@", flag, countryName];
    cell.detailTextLabel.text = code;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *userInfo = [self getUserInfoForIndexPath:indexPath];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidSelectCountryCode object:nil userInfo:userInfo];
    if (_searchController.isActive) [_searchController setActive:NO];
    [self dismissViewControllerAnimated:YES completion:^{
        [[CountryCallingCode sharedInstance].delegate updateCountryData];
    }];
}

- (IBAction)onCancelPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper methods

- (NSDictionary *)getUserInfoForIndexPath:(NSIndexPath *)indexPath {
    NSString *flag = [self getFlagForIndexPath:indexPath];
    NSString *code = [self getCallingCodeForIndexPath:indexPath];
    return @{ kCCCode: code,
              kCCFlag: flag };
}

- (NSString *)getFlagForIndexPath:(NSIndexPath *)indexPath {
    if (_searchController.isActive && ![_searchController.searchBar.text isEqualToString:@""]) {
        return [_filteredDataModel getCountryFlagForCode:[_filteredDataModel getCountryCodeForFilteredModelAtIndexPath:indexPath]];
    }
    
    return [_dataModel getCountryFlagForCode:[_dataModel getCountryCodeAtIndexPath:indexPath]];
}

- (NSString *)getCallingCodeForIndexPath:(NSIndexPath *)indexPath {
    if (_searchController.isActive && ![_searchController.searchBar.text isEqualToString:@""]) {
        return [_filteredDataModel filteredCountryDialCodeFor:indexPath];
    }
    
    return [_dataModel countryDialCodeForCode:[_dataModel getCountryCodeAtIndexPath:indexPath]];
}

- (NSString *)getCountryNameForIndexPath:(NSIndexPath *)indexPath {
    if (_searchController.isActive && ![_searchController.searchBar.text isEqualToString:@""]) {
        return [_filteredDataModel filteredCountryNameFor:indexPath];
    }
    
    return [_dataModel countryNameForCode:[_dataModel getCountryCodeAtIndexPath:indexPath]];
}

@end
