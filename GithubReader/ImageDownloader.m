//
//  ImageDownloader.m
//  GithubReader
//
//  Created by Igor Iliyn on 5/4/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "ImageDownloader.h"

@interface ImageDownloader()
@property (strong, nonatomic) NSString        *strURL;
@property (strong, nonatomic) NSMutableData   *data;
@property (nonatomic, strong) NSURLConnection *imageConnection;
@end

@implementation ImageDownloader

- (id)initWithStringURL:(NSString *)stringURL
{
    if (self = [super init])
    {
        self.strURL = stringURL;
    }
    return self;
}

- (void)startDownload
{
    self.data = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.strURL]];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.imageConnection = connection;
}


#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.data = nil;
    self.imageConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.imageConnection = nil;
    
    // call our delegate and tell it that our icon is ready for display
    if (self.completionHandler)
    {
        self.completionHandler(self.data);
    }
}


@end
