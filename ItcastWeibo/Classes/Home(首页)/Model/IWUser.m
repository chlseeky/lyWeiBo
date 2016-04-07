//
//  IWUser.m
//  ItcastWeibo
//
//  Created by yz on 14/11/12.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWUser.h"
#import "UIButton+WebCache.h"

@implementation IWUser

MJCodingImplementation

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:_name forKey:@"Name"];
//    [aCoder encodeInteger:_followers_count forKey:@"FollowersCount"];
//    [aCoder encodeInteger:_friends_count forKey:@"FriendsCount"];
//    [aCoder encodeInteger:_statuses_count forKey:@"StatusesCount"];
//    [aCoder encodeObject:_avatar_large forKey:@"ProfileImageUrl"];
//    [aCoder encodeObject:_profile_user_img forKey:@"ProfileUserImg"];
////    [aCoder encodeObject:_description forKey:@"Description"];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        _name = [aDecoder decodeObjectForKey:@"Name"];
//        _followers_count = [aDecoder decodeIntegerForKey:@"FollowersCount"];
//        _friends_count = [aDecoder decodeIntegerForKey:@"FriendsCount"];
//        _statuses_count = [aDecoder decodeIntegerForKey:@"StatusesCount"];
//        _avatar_large = [aDecoder decodeObjectForKey:@"ProfileImageUrl"];
//        _profile_user_img = [aDecoder decodeObjectForKey:@"ProfileUserImg"];
////        _description = [aDecoder decodeObjectForKey:@"Description"];
//    }
//    return self;
//}


@end
