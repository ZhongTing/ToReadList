//
//  BookParser.h
//  ToReadList
//
//  Created by ZhongTing on 2015/6/15.
//  Copyright (c) 2015年 ZhongTing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookParser : NSObject
- (BOOL)validateISBN:(NSString*)ISBN;
@end
