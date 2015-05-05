//
//  ImageDownloader.h
//  GithubReader
//
//  Created by Igor Iliyn on 5/4/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownloader : NSObject

@property (nonatomic, copy) void (^completionHandler)(NSMutableData *);

- (id)initWithStringURL:(NSString *)stringURL;
- (void)startDownload;

@end
