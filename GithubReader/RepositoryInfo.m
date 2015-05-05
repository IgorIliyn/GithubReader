//
//  RepositoryInfo.m
//  GithubReader
//
//  Created by Igor Iliyn on 5/4/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "RepositoryInfo.h"

@implementation RepositoryInfo

- (NSString *)getLanguageString
{
    return [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Language:", nil),self.language];
}

@end
