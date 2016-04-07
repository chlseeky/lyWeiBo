//
//  IWStatusTool.m
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWStatusTool.h"
#import "IWAccountTool.h"
#import "IWAccount.h"
#import "IWHttpTool.h"
#import "MJExtension.h"
#import "IWStatus.h"
#import "IWStatusParam.h"
#import "IWStatusResult.h"

#import "IWStatusFrame.h"

#import "IWStatusCacheTool.h"

@implementation IWStatusTool

+ (void)moreStatusesWithID:(id)ID success:(void (^)(NSArray *statusFrameArr))success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    IWStatusParam *param = [[IWStatusParam alloc] init];
    param.access_token = [IWAccountTool account].access_token;
    param.max_id = ID;
    
     MLOG(@"%@",param.access_token);
    // 加载缓存数据 https://api.weibo.com/2/statuses/friends_timeline.json?access_token=2.0044HbrCRriPvC06c06ea17dLHnX3E
    NSArray *statuses =  [IWStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (IWStatus *status in statuses) {
            IWStatusFrame *statusF = [[IWStatusFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }
        
        // 不需要在发送请求
        return;
    }

    
    // 发送请求
    [IWHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(id responseObject) {
        
        // 存储数据
        [IWStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
        IWStatusResult *result = [IWStatusResult mj_objectWithKeyValues:responseObject];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (IWStatus *status in result.statuses) {
            IWStatusFrame *statusF = [[IWStatusFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)newStatusesWithID:(id)ID success:(void (^)(NSArray *statusFrameArr))success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    IWStatusParam *param = [[IWStatusParam alloc] init];
    param.access_token = [IWAccountTool account].access_token;
    param.since_id = ID;
    
#warning  先从缓存中获取数据
//    NSArray *statuses =  [IWStatusCacheTool statusesWithParam:param];
//    if (statuses.count) {
//        
//        NSMutableArray *arrM = [NSMutableArray array];
//        for (IWStatus *status in statuses) {
//            IWStatusFrame *statusF = [[IWStatusFrame alloc] init];
//            statusF.status = status;
//            [arrM addObject:statusF];
//        }
//        if (success) {
//            success(arrM);
//        }
//        
//        // 不需要在发送请求
//        return;
//    }
    
    
    // 发送请求
    [IWHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(id responseObject) {
        
#warning  存储数据
        [IWStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
        //新版本并不能对模型里面的对象转成模型，所以需要在去除每一个对象时再来一次字典转模型，错了新版方法前加了mj
        IWStatusResult *result = [IWStatusResult mj_objectWithKeyValues:responseObject];
        
        NSDictionary *plist = result.mj_keyValues;
        [plist writeToFile:@"/Users/ly/Desktop/status.plist" atomically:YES];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (IWStatus *status in result.statuses) {
//            IWStatus *sta = [IWStatus mj_objectWithKeyValues:status];//此处如上所述
            IWStatusFrame *statusF = [[IWStatusFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }

        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}


@end
