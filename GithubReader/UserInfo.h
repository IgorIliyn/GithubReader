//
//  UserInfo.h
//  GithubReader
//
//  Created by Igor Iliyn on 5/4/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSString *profileURL;
@property (nonatomic, strong) NSNumber *countFollowers;
@property (nonatomic, strong) NSNumber *countFollowing;

- (NSString *)getFollowersString;
- (NSString *)getFollowingString;
- (NSString *)getNameString;

@end
