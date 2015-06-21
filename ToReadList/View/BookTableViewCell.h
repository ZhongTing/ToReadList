//
//  BookTabelCellTableViewCell.h
//  ToReadList
//
//  Created by ZhongTing on 2015/6/21.
//  Copyright (c) 2015年 ZhongTing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface BookTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel* authorLabel;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* subTitileLabel;
@property (weak, nonatomic) IBOutlet UIImageView* coverImagView;

- (void)initWithBook:(Book*)book;
@end
