//
//  DataLoader.h
//  GithubReader
//
//  Created by Igor Ilyin on 5/3/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLoader : NSObject

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) void (^complationHandler)(NSMutableData *);

- (void)userSearch:(NSString *)name;
- (void)userInfo:(NSString *)name;
- (void)userRepositories:(NSString *)name;

@end
