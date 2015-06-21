//
//  BookTabelCellTableViewCell.m
//  ToReadList
//
//  Created by ZhongTing on 2015/6/21.
//  Copyright (c) 2015年 ZhongTing. All rights reserved.
//

#import "BookTableViewCell.h"
#import <UIImageView+AFNetworking.h>

@implementation BookTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithBook:(Book*)book
{
    self.authorLabel.text = book.author;
    self.titleLabel.text = book.title;
    self.subTitileLabel.text = book.subtitle;
    [self.coverImagView setImageWithURL:[NSURL URLWithString:book.coverUrl] placeholderImage:[UIImage imageNamed:@"default_cover"]];
}
@end
