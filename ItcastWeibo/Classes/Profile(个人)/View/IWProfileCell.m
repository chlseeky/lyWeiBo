//
//  IWProfileCell.m
//  ItcastWeibo
//
//  Created by yz on 14/11/17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWProfileCell.h"

@implementation IWProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detailTextLabel.left = CGRectGetMaxX(self.textLabel.frame) + 5;
}

@end
