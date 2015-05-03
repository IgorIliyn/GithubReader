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

@end
