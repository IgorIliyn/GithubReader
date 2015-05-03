//
//  ViewController.h
//  GithubReader
//
//  Created by Igor Iliyn on 4/22/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataLoader.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *tellButton;
@property (weak, nonatomic) IBOutlet UILabel *labelInvite;

@end

