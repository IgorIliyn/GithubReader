//
//  MoreInfoViewController.h
//  GithubReader
//
//  Created by Igor Iliyn on 5/4/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parser.h"
#import "DataLoader.h"
#import "ImageDownloader.h"
#import "RepoTableViewCell.h"
#import <CoreData/CoreData.h>

@interface MoreInfoViewController : UIViewController

@property (nonatomic, strong) NSString *userName;
@property (strong, nonatomic) IBOutlet UILabel *followersLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *followingLabel;
@property (strong, nonatomic) IBOutlet UILabel *repoLabel;
@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;


@end
