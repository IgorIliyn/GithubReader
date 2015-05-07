//
//  RepoTableViewCell.h
//  GithubReader
//
//  Created by Igor Iliyn on 5/4/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAGithubEngine.h" 

@protocol RepositoryHandle <NSObject>

- (void)inputCredentials;

@end

@interface RepoTableViewCell : UITableViewCell

@property id<RepositoryHandle> repoDelegate;

@property (nonatomic, strong) IBOutlet UILabel *repoNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *repoLanguageLabel;
@property (nonatomic, strong) IBOutlet UILabel *repoForkLabel;
@property (nonatomic, strong) IBOutlet UILabel *repoStarLabel;

@property (nonatomic, strong) NSString *fork_url;
@property (nonatomic, strong) NSString *star_url;

@property (nonatomic, strong) NSString *userLogin;
@property (nonatomic, strong) NSString *userPassword;

@end
