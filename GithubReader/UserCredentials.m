//
//  UserCredentials.m
//  GithubReader
//
//  Created by Igor Ilyin on 5/7/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "UserCredentials.h"

@implementation UserCredentials

#pragma mark NSCoding protocol methods

@synthesize login;
@synthesize password;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.login forKey:@"login"];
    [aCoder encodeObject:self.password forKey:@"password"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if ( self != nil )
    {
        self.login = [aDecoder decodeObjectForKey:@"login"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
    }
    return self;
}

@end
