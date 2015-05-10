//
//  SaveUserInfoViewController.h
//  GithubReader
//
//  Created by Igor Ilyin on 5/10/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserInfo;

@interface SaveUserInfoViewController : UIViewController

@property (nonatomic, strong) UserInfo *userInformation;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
