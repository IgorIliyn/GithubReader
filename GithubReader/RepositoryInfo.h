//
//  RepositoryInfo.h
//  GithubReader
//
//  Created by Igor Iliyn on 5/4/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepositoryInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSNumber *countStars;
@property (nonatomic, strong) NSNumber *countForks;

- (NSString *)getLanguageString;

@end
