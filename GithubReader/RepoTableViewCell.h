//
//  RepoTableViewCell.h
//  GithubReader
//
//  Created by Igor Iliyn on 5/4/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepoTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *repoNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *repoLanguageLabel;
@property (nonatomic, strong) IBOutlet UILabel *repoForkLabel;
@property (nonatomic, strong) IBOutlet UILabel *repoStarLabel;

@end
