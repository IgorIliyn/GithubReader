//
//  SocialViewController.m
//  GithubReader
//
//  Created by Igor Ilyin on 5/10/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "SocialViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface SocialViewController ()

@end

@implementation SocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAppearance];
    [self initShareButtons];
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
    
    //Icon like button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"github.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    [button addTarget:self action:@selector(homeAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}

- (void)initShareButtons
{
    //Facebook share button add
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:self.shareURL];
    FBSDKShareButton *button = [[FBSDKShareButton alloc]init];
    [self.view addSubview:button];
    button.center = self.view.center;
    button.shareContent = content;
    
    //Other social shared buttons ...
}

- (void)homeAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
