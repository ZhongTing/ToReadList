//
//  BookParser.m
//  ToReadList
//
//  Created by ZhongTing on 2015/6/15.
//  Copyright (c) 2015年 ZhongTing. All rights reserved.
//

#import "BookParser.h"
#import <AFNetworking.h>

@implementation BookParser
NSString* key = @"AIzaSyCIYDMem9u56epefNvw_rNFkbOGyv8o2Hw";
NSString* api = @"https://www.googleapis.com/books/v1/volumes?q=isbn:%@&key=%@";

- (BOOL)validateISBN:(NSString*)ISBN
{
    return [ISBN length] == 10 || [ISBN length] == 13;
}

- (void)requestBookInfoWithISBN:(NSString*)ISBN
{
    ISBN = @"9780132350884";
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:api, ISBN, key]
        parameters:nil
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            [self parse:responseObject];
        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            NSLog(@"Error: %@", error);
        }];
}

- (void)parse:(NSDictionary*)data
{
}
@end
