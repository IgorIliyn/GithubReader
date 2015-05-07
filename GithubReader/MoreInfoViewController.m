//
//  MoreInfoViewController.m
//  GithubReader
//
//  Created by Igor Iliyn on 5/4/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "MoreInfoViewController.h"
#import <UAGithubEngine/UAGithubEngine.h>

@interface MoreInfoViewController ()

@property (nonatomic, strong) UserInfo       *userInfo;
@property (nonatomic, strong) NSMutableArray *repositoriesArray;

@end

@implementation MoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAppearance];
    self.repositoriesArray = [NSMutableArray array];
    
    DataLoader *loader = [[DataLoader alloc]init];
    Parser *parser = [[Parser alloc]init];
    loader.complationHandler = ^(NSMutableData *data){
        self.userInfo = [parser parseUserInfo:data];
        [self updateUserInfoView];
    };
    [loader userInfo:self.userName];
    
    DataLoader *reposLoader = [[DataLoader alloc]init];
    Parser *parserRepos = [[Parser alloc]init];
    reposLoader.complationHandler = ^(NSMutableData *data){
        self.repositoriesArray = [parserRepos parseRepositories:data];
        [self.tableView reloadData];
    };
    [reposLoader userRepositories:self.userName];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Appearance

- (void)initAppearance
{
    //Set text strings through page
    self.title = NSLocalizedString(@"Github Reader", nil);
    self.repoLabel.text = NSLocalizedString(@"Repositories", nil);
    
    //Icon like button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"github.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    [button addTarget:self action:@selector(homeAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    self.followersLabel.alpha = 0;
    self.followingLabel.alpha = 0;
    self.userNameLabel.alpha  = 0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RepoTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellRepo"];
}

- (void)updateUserInfoView
{
    self.followersLabel.alpha = 1;
    self.followingLabel.alpha = 1;
    self.userNameLabel.alpha  = 1;
    
    self.followingLabel.text = [self.userInfo getFollowingString];
    self.followersLabel.text = [self.userInfo getFollowersString];
    self.userNameLabel.text  = [self.userInfo getNameString];
    
    ImageDownloader *avatar = [[ImageDownloader alloc]initWithStringURL:[self.userInfo avatarURL]];
    avatar.completionHandler = ^(NSMutableData *data){
        self.avatarImage.image = [UIImage imageWithData:data];
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.width / 2;
        self.avatarImage.clipsToBounds = YES;
        [self.loader stopAnimating];
    };
    [avatar startDownload];
}

#pragma mark User Action

- (void)homeAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareSocial:(UIButton *)sender
{
    [self inputCredentials];
}

- (IBAction)saveUserInfo:(UIButton *)sender
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (context) {
        NSManagedObject *itemModel = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:context];
        
        [itemModel setValue:self.userInfo.name forKey:@"userName"];
        [itemModel setValue:self.userInfo.countFollowers forKey:@"followers"];
        [itemModel setValue:self.userInfo.countFollowing forKey:@"following"];
        
        NSError *error;
        
        if (![context save:&error])
        {
            NSLog(@"Error saving item!!!");
        }
    }
}

- (IBAction)viewProfilePage:(UIButton *)sender
{
    //Open user profile in external brouser
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.userInfo.profileURL]];
}

#pragma mark User Credential methods

- (void)inputCredentials
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Authorization", nil)
                                                                    message:NSLocalizedString(@"Please enter your login and password", nil)
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"Save", nil) style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   
                                                   NSString *login = ((UITextField*)[[alert textFields] objectAtIndex:0]).text;
                                                   NSString *password = ((UITextField*)[[alert textFields] objectAtIndex:1]).text;
                                                   
                                                   if ([login isEqualToString:@""] || [password isEqualToString:@""]) {
                                                       [self saveCredentials:login password:password];
                                                   }
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Login", nil);
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Password", nil);
        textField.secureTextEntry = YES;
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)saveCredentials:(NSString *)login password:(NSString *)password
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:login forKey:@"LOGIN"];
    [defaults setObject:password forKey:@"PASSWORD"];
    
}

- (void)fillAllFieldsPlease
{
    
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.repositoriesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellRepo" forIndexPath:indexPath];
    RepositoryInfo *repoInfo = [self.repositoriesArray objectAtIndex:indexPath.row];
    cell.fork_url = repoInfo.fork_url;
    cell.star_url = repoInfo.star_url;
    cell.repoNameLabel.text = repoInfo.name;
    cell.repoLanguageLabel.text = [repoInfo getLanguageString];
    cell.repoForkLabel.text = [repoInfo.countForks stringValue];
    cell.repoStarLabel.text = [repoInfo.countStars stringValue];
    cell.repoDelegate = self;
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"goToWebPage"]) {
        [[segue destinationViewController] setProfileURL:self.userInfo.profileURL];
    }
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


@end
