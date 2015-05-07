//
//  UserCredentials.h
//  GithubReader
//
//  Created by Igor Ilyin on 5/7/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCredentials : NSObject
<
    NSCoding
>

@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *password;

@end
