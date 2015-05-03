//
//  DataLoader.m
//  GithubReader
//
//  Created by Igor Ilyin on 5/3/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "DataLoader.h"

#define SEARCH_USERS_URL @"https://api.github.com/search/users?q="

@implementation DataLoader

- (void)userSearch:(NSString *)name
{
    Parser *parser = [[Parser alloc]init];
    self.session = [NSURLSession sharedSession];
    [[self.session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SEARCH_USERS_URL,name]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error)
        {
            self.complationHandler([parser parseUserNames:data]);
        }
        else
        {
            NSLog(@"%@",error);
        }
        
    }] resume];
}

- (void)userInfo:(NSString *)name
{
    
}

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

@end
