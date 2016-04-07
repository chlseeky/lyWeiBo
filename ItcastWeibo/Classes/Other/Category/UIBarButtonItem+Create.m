//
//  UIBarButtonItem+Create.m
//  ItcastWeibo
//
//  Created by yz on 14/11/5.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "UIBarButtonItem+Create.h"

@implementation UIBarButtonItem (Create)

+ (instancetype)barButtonItemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (title) {
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:IWColor(100, 100, 100) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:16]];
        
        button.width = 30+ size.width;
        [button setTitle:title forState:UIControlStateNormal];
        //自定义UIBarButtonItem 10px 便宜纠正
         [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10,0, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -10,0, 0)];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//内容左对齐
    }
    return  [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
