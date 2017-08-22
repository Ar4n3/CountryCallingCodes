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
    if (_searchController.isActive && ![_searchController.searchBar.text isEqualToString:@""]) {
        NSString *countryCode = [_filteredDataModel getCountryCodeForFilteredModelAtIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@\t%@", [_filteredDataModel getCountryFlagForCode:countryCode], [_filteredDataModel filteredCountryNameFor:indexPath]];
        cell.detailTextLabel.text = [_filteredDataModel filteredCountryDialCodeFor:indexPath];
        
        return cell;
    }
    NSString *countryCode = [_dataModel getCountryCodeAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@\t%@", [_dataModel getCountryFlagForCode:countryCode], [_dataModel countryNameForCode:countryCode]];
    cell.detailTextLabel.text = [_dataModel countryDialCodeForCode:countryCode];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    [[CountryCallingCode sharedInstance] updateDataWithCode:cell.detailTextLabel.text andFlag:[_dataModel getCountryFlagForCode:[_dataModel getCountryCodeAtIndexPath:indexPath]]];
    if (_searchController.isActive) [_searchController setActive:NO];
    [self dismissViewControllerAnimated:YES completion:^{
        [[CountryCallingCode sharedInstance].delegate updateCountryData];
    }];
}

- (IBAction)onCancelPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
