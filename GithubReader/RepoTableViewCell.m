//
//  RepoTableViewCell.m
//  GithubReader
//
//  Created by Igor Iliyn on 5/4/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "RepoTableViewCell.h"

@implementation RepoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *) reuseIdentifier
{
    return @"CellRepo";
}

- (IBAction)forkRepoAction:(UIButton *)sender
{
    UAGithubEngine *engine = [[UAGithubEngine alloc] initWithUsername:@"IgorIliyn" password:@"discovery47" withReachability:YES];
    
   [engine forkRepository:self.fork_url inOrganization:nil success:^(id obj) {
        NSLog(@"%@",obj);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (IBAction)starRepoAction:(UIButton *)sender
{
    if ([self checkCredentials])
    {
        UAGithubEngine *engine = [[UAGithubEngine alloc] initWithUsername:self.userLogin password:self.userPassword withReachability:YES];
        [engine starRepository:self.star_url success:^(id obj) {
            NSLog(@"SUCCESS");
        } failure:^(NSError *error) {
            NSLog(@"ERROR");
        }];
    }
    else
    {
        if ([self.repoDelegate respondsToSelector:@selector(inputCredentials)]) {
            [self.repoDelegate inputCredentials];
        }
    }
    
}

#pragma mark User Credentials methods

- (BOOL)checkCredentials
{
    BOOL flag = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *shData = [defaults objectForKey:@"CREDENTIALS"];
    UserCredentials *credentials = (UserCredentials *)[NSKeyedUnarchiver unarchiveObjectWithData:shData];
    
    if (credentials)
    {
        self.userLogin = credentials.login;
        self.userPassword = credentials.password;
        flag = YES;
    }
    
    return flag;
}

@end
