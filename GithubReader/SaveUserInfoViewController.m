//
//  SaveUserInfoViewController.m
//  GithubReader
//
//  Created by Igor Ilyin on 5/10/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "SaveUserInfoViewController.h"
#import "UserInfo.h"
#import <CoreData/CoreData.h>

@interface SaveUserInfoViewController ()
@property (nonatomic, strong) NSMutableArray *savedUsers;
@end

@implementation SaveUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.savedUsers = [NSMutableArray array];
    [self initAppearance];
    [self retrieveItems];
    [self saveUserInfo];
    // Do any additional setup after loading the view.
}

#pragma mark Appearance

- (void)initAppearance
{
    //Set text strings through page
    self.title = NSLocalizedString(@"Github Reader", nil);
    
    //Icon like button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"github.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    [button addTarget:self action:@selector(homeAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}

- (void)homeAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)saveUserInfo
{
    BOOL exist = NO;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    for (NSManagedObject *obj in self.savedUsers) {
        if ([[obj valueForKey:@"userName"] isEqualToString:self.userInformation.name]) {
            exist = YES;
            break;
        }
    }
    
    if (context && !exist) {
        NSManagedObject *itemModel = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:context];
        
        [itemModel setValue:self.userInformation.name forKey:@"userName"];
        [itemModel setValue:self.userInformation.countFollowers forKey:@"followers"];
        [itemModel setValue:self.userInformation.countFollowing forKey:@"following"];
        
        NSError *error;
        
        if (![context save:&error])
        {
            NSLog(@"Error saving item!!!");
        }
        else
        {
            [self retrieveItems];
            [self.tableView reloadData];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Core Data Support

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (void)retrieveItems
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"UserInfo"];
    
    NSError *error;
    
    self.savedUsers = [[context executeFetchRequest:request error:&error] mutableCopy];

    if (error) {
        NSLog(@"ERROR FETCHING! %@",[error localizedDescription]);
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.savedUsers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    // Configure the cell...
    NSManagedObject *item = [self.savedUsers objectAtIndex:indexPath.row];
    cell.textLabel.text = [item valueForKey:@"userName"];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
