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
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *searchBarContainerView;
@property (strong, nonatomic) UIView *alphaView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarContainerViewBottomConstraint;
@end

CGFloat const kCornerRadius = 8.0f;

@implementation CountryCodesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configurePresentingViewControllerUI];
    _dataModel = [[CountryCodeDataModel alloc] init];
    [self configureSearchController];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _sectionIndexTitles = [_dataModel getSectionIndexTitles];
    [_tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self clearPresentingViewControllerUI];
}

- (void)dealloc {
    [_searchController.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure UI

- (void)configurePresentingViewControllerUI {
    _alphaView = [[UIView alloc] initWithFrame:self.presentingViewController.view.bounds];
    [_alphaView setBackgroundColor:[UIColor clearColor]];
    [_alphaView setAlpha:0.5];
    [self.presentingViewController.view addSubview:_alphaView];
    [UIView animateWithDuration:0.2 animations:^{
        [_alphaView setBackgroundColor:[UIColor blackColor]];
    }];
}

- (void)clearPresentingViewControllerUI {
    [_alphaView removeFromSuperview];
}

#pragma mark - Rotation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    CGFloat delay = 0.0;
    if (size.width < self.view.bounds.size.width) {
        delay = 1.0;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_alphaView setFrame:CGRectMake(0, 0, size.width, size.height)];
    });
    [_searchController.searchBar setFrame:CGRectMake(0, 0, size.width, _searchController.searchBar.frame.size.height)];
}

#pragma mark - Search Controller Delegate

- (void)configureSearchController {
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [_searchController.searchBar setTintColor:[UIColor lightGrayColor]];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = false;
    _searchController.definesPresentationContext = true;
    _searchBarContainerView.layer.cornerRadius = kCornerRadius;
    _searchBarContainerViewBottomConstraint.constant = -kCornerRadius+(kCornerRadius/2/2);
    [_searchBarContainerView addSubview:_searchController.searchBar];
    [_searchController.searchBar sizeThatFits:_searchBarContainerView.frame.size];
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
    [[CountryCallingCode sharedInstance].delegate updateCountryData];
    [self dismissViewControllerAnimated:YES completion:^{
//        [[CountryCallingCode sharedInstance].delegate updateCountryData];
    }];
}

- (IBAction)onDismiss:(UIButton *)sender {
    if (_searchController.isActive) [_searchController setActive:NO];
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
