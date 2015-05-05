//
//  UserInfo.m
//  GithubReader
//
//  Created by Igor Iliyn on 5/4/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "UserInfo.h"



@implementation UserInfo

@synthesize avatarURL;

- (NSString *)getFollowersString
{
    return [NSString stringWithFormat:@"%@\n%@",self.countFollowers,NSLocalizedString(@"followers", nil)];
}

- (NSString *)getFollowingString
{
    return [NSString stringWithFormat:@"%@\n%@",self.countFollowing,NSLocalizedString(@"following", nil)];
}

- (NSString *)getNameString
{
    if (self.company)
    {
        return [NSString stringWithFormat:@"%@, %@",self.name,self.company];
    }
    else
    {
        return self.name;
    }
}

@end
