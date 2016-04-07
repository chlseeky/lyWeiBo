//
//  IWUser.h
//  ItcastWeibo
//
//  Created by yz on 14/11/12.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//  http://www.tuicool.com/articles/a6VrMr

#import <Foundation/Foundation.h>
#import "MJExtension.h"


@interface IWUser : NSObject<NSCoding>

/**
 *  友好显示名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  粉丝数
 */
@property (nonatomic, assign)NSInteger followers_count;

/**
 *  关注数
 */
@property (nonatomic, assign)NSInteger friends_count;
/**
 *  微博数
 */
@property (nonatomic, assign)NSInteger statuses_count;

/**
 *  用户头像地址
 */
@property (nonatomic, strong) NSURL *avatar_large;

/**
 *  用户描述
 */
@property (nonatomic, copy)NSString *desc;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;

/**
 *  缓存用户头像
 */
@property (nonatomic ,strong)UIImage *profile_user_img;

@property (nonatomic, assign,getter=isVip) BOOL vip;

@end
