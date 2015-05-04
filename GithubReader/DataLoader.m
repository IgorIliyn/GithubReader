//
//  DataLoader.m
//  GithubReader
//
//  Created by Igor Ilyin on 5/3/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "DataLoader.h"

#define SEARCH_USERS_URL @"https://api.github.com/search/users?q="
#define USER_INFO_URL @"https://api.github.com/users/"

@interface DataLoader()

@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableData   *data;
@property int code;

@end

@implementation DataLoader

- (void)userSearch:(NSString *)name
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SEARCH_USERS_URL,name]]];
    self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

- (void)userInfo:(NSString *)name
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",USER_INFO_URL,name]]];
    self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    self.code = (int)[httpResponse statusCode];
    self.data = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.connection = nil;
    self.data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"%@",[[NSString alloc]initWithData:self.data encoding:NSUTF8StringEncoding]);
    switch (self.code)
    {
        case 200:
            if (self.complationHandler)
            {
                self.complationHandler(self.data);
            }
            break;
            
        default:
            
            break;
    }
    
}


@end
