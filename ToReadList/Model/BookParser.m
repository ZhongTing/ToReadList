//
//  BookParser.m
//  ToReadList
//
//  Created by ZhongTing on 2015/6/15.
//  Copyright (c) 2015年 ZhongTing. All rights reserved.
//

#import "BookParser.h"

@implementation BookParser

- (BOOL)validateISBN:(NSString*)ISBN
{
    return [ISBN length] == 10 || [ISBN length] == 13;
}
@end
