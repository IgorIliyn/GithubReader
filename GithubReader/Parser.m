//
//  Parser.m
//  GithubReader
//
//  Created by Igor Ilyin on 5/3/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "Parser.h"

@implementation Parser

- (NSMutableArray *)parseUserNames:(NSData *)data
{
    NSError *parseError;
    
    NSDictionary *names = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
    
    NSMutableArray *namesArray = [NSMutableArray array];
    if (!parseError)
    {
        for (NSDictionary *item in names[@"items"])
        {
            [namesArray addObject:item[@"login"]];
        }
    }
    else
    {
        NSLog(@"%@",parseError);
    }
    
    return namesArray;
}

- (UserInfo *)parseUserInfo:(NSData *)data
{
    UserInfo *userInfo = [[UserInfo alloc]init];
    
    NSError *parseError;
    
    NSDictionary *user_info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];

    if (!parseError)
    {
        if (user_info[@"name"] && ![user_info[@"name"] isKindOfClass:[NSNull class]] && ![user_info[@"name"] isEqualToString:@""])
        {
            [userInfo setName:user_info[@"name"]];
        }
        else
        {
            [userInfo setName:user_info[@"login"]];
        }
        if (user_info[@"company"] && ![user_info[@"company"] isKindOfClass:[NSNull class]] && ![user_info[@"company"] isEqualToString:@""]) {
            [userInfo setCompany:user_info[@"company"]];
        }
        
        [userInfo setCountFollowers:user_info[@"followers"]];
        [userInfo setCountFollowing:user_info[@"following"]];
        [userInfo setAvatarURL:user_info[@"avatar_url"]];
        [userInfo setProfileURL:user_info[@"html_url"]];
        
    }
    else
    {
        NSLog(@"%@",parseError);
    }
    return userInfo;
}

- (NSMutableArray *)parseRepositories:(NSData *)data
{
    NSError *parseError;
    
    NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
    
    NSMutableArray *namesArray = [NSMutableArray array];
    if (!parseError)
    {
        for (NSDictionary *repo in repos)
        {
            RepositoryInfo *repository = [[RepositoryInfo alloc]init];
            [repository setName:repo[@"name"]];
            if (![repo[@"language"] isKindOfClass:[NSNull class]])
            {
                [repository setLanguage:repo[@"language"]];
            }
            else
            {
                [repository setLanguage:@"no name"];
            }
            [repository setFork_url:repo[@"full_name"]];
            [repository setStar_url:repo[@"full_name"]];
            [repository setCountStars:repo[@"stargazers_count"]];
            [repository setCountForks:repo[@"forks_count"]];
            [namesArray addObject:repository];
        }
    }
    else
    {
        NSLog(@"%@",parseError);
    }
    
    return namesArray;
}

@end
