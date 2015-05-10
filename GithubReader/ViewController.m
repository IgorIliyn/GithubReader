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

- (void)viewDidLoad
{
    [super viewDidLoad];
    //init
    [self initAppearance];
    self.userNames = [NSMutableArray array];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.userNames removeAllObjects];
    [self.tableView reloadData];
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
    Parser *parser = [[Parser alloc]init];
    loader.complationHandler = ^(NSMutableData *data){
        self.userNames = [parser parseUserNames:data];
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
    
    
}

#pragma mark Animation

//Animate search Bar
- (void)searchAnimation
{
    self.viewOffset = self.searchBar.frame.origin.y - 64;
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
    //Go to MoreInfoController if userneme selected
    if (![self.searchBar.text isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"goToMoreInfo" sender:self];
    }
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

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *userName = [self.userNames objectAtIndex:indexPath.row];
    
    self.searchBar.text = userName;
    //hide search results
    [self searchAnimation];
    //hide keyboard
    [self.view endEditing:YES];
}

#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToMoreInfo"]) {
        [[segue destinationViewController] setUserName:self.searchBar.text];
    }
}


@end
