//
//  Parser.h
//  GithubReader
//
//  Created by Igor Ilyin on 5/3/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "RepositoryInfo.h"

@interface Parser : NSObject

- (NSMutableArray *)parseUserNames:(NSData *)data;
- (UserInfo *)parseUserInfo:(NSData *)data;
- (NSMutableArray *)parseRepositories:(NSData *)data;

@end
