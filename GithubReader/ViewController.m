//
//  ViewController.m
//  GithubReader
//
//  Created by Igor Iliyn on 4/22/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property CGFloat viewOffset;
@property (nonatomic, strong) NSMutableArray *userNames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAppearance];
    self.userNames = [NSMutableArray array];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}// return NO to not become first responder

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self searchAnimation];
}// called when text starts editing

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}// return NO to not resign first responder

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}// called when text ends editing

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    DataLoader *loader = [[DataLoader alloc]init];
    loader.complationHandler = ^(NSMutableArray *userNamesArray){
        self.userNames = userNamesArray;
        [self.tableView reloadData];
    };
    [loader userSearch:searchBar.text];
}// called when text changes (including clear)

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0)
{
    return YES;
}// called before text changes

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchAnimation];
    [self.view endEditing:YES];
}// called when keyboard search button pressed

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    
}// called when bookmark button pressed

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}// called when cancel button pressed

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2)
{
    
}// called when search results button pressed



#pragma mark Appearance

- (void)initAppearance
{
    //Set text strings through page
    self.title = NSLocalizedString(@"Github Reader", nil);
    self.labelInvite.text = NSLocalizedString(@"Input username to know more:", nil);
    self.searchBar.placeholder = NSLocalizedString(@"some Github username", nil);
    [self.tellButton setTitle:NSLocalizedString(@"Tell me more!", nil) forState:UIControlStateNormal];
    
    //Icon like button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"github.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    [button addTarget:self action:@selector(homeAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    self.viewOffset = self.searchBar.frame.origin.y - 44;
    
    
}

#pragma mark Animation

- (void)searchAnimation
{
    CGRect frame = self.view.frame;;
    CGFloat alpha;
    
    if (self.view.frame.origin.y < 0)
    {
        frame.origin.y = 0;
        alpha = 0;
    }
    else
    {
        frame.origin.y -= self.viewOffset;
        alpha = 1;
    }
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.view.frame = frame;
                         self.tableView.alpha = alpha;
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

#pragma mark User Action

- (IBAction)tellMeMoreAction:(UIButton *)sender
{
    
}

- (void)homeAction
{
    [self.view endEditing:YES];
    [self searchAnimation];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [self.userNames objectAtIndex:indexPath.row];
    return cell;
}


@end
