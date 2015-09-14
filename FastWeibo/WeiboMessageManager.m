//
//  WeiboMessageManager.m
//  FastWeibo
//
//  Created by Bill Clock on 15/1/13.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "WeiboMessageManager.h"
#import "WeiboAccountManager.h"
#import "WeiboHttpManager.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "CoreData+MagicalRecord.h"
#import "CocoaLumberjack/DDLog.h"


@implementation WeiboMessageManager


+ (instancetype)sharedManager {
    static WeiboMessageManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[WeiboMessageManager alloc] init];
    });
    
    return _sharedManager;
}


- (void)getHomeLineWithSinceID:(int64_t)sinceID maxID:(int64_t)maxID count:(int)count page:(int)page baseApp:(int)baseApp feature:(int)feature success:(StatusSuccess)success failure:(StatusFailure)failure
{
    WeiboAccount *account = [[WeiboAccountManager sharedManager] account];
    NSString *authToken = account.accessToken;

    NSMutableDictionary  *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:authToken, @"access_token", nil];
    if (sinceID >= 0) {
        NSString *tempString = [NSString stringWithFormat:@"%lld", sinceID];
        [params setObject:tempString forKey:@"since_id"];
    }
    if (maxID >= 0) {
        NSString *tempString = [NSString stringWithFormat:@"%lld", maxID];
        [params setObject:tempString forKey:@"max_id"];
    }
    if (count >= 0) {
        NSString *tempString = [NSString stringWithFormat:@"%d", count];
        [params setObject:tempString forKey:@"count"];
    }
    if (page >= 0) {
        NSString *tempString = [NSString stringWithFormat:@"%d", page];
        [params setObject:tempString forKey:@"page"];
    }
    if (baseApp >= 0) {
        NSString *tempString = [NSString stringWithFormat:@"%d", baseApp];
        [params setObject:tempString forKey:@"baseApp"];
    }
    if (feature >= 0) {
        NSString *tempString = [NSString stringWithFormat:@"%d", feature];
        [params setObject:tempString forKey:@"feature"];
    }


    [[WeiboHttpManager sharedManager] GET:@"2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        
        if (success == nil) return;
        
        // 1、将返回的JSON转换成微博模型并保存到数组
        NSMutableArray *statuses = [NSMutableArray array];
        for (NSDictionary *item in responseObject[@"statuses"]) {
            // 将JSON中解析的数据保存到数据模型中
//            NSLog(@"Status: %@", item);
            NSError *error = nil;
            StatusModel *status = [MTLJSONAdapter modelOfClass:StatusModel.class fromJSONDictionary:item error:&error];
 
            NSLog(@"Status Text: %@", status.text);
            NSLog(@"User : %@", status.user.screenName);
            NSLog(@"PicUrl : %@", status.picUrls);
            
            [statuses addObject:status];
        }
        
        
        // 2、将数组返回给Block形参供方法调用者使用
        success(statuses);

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure == nil) return ;
        failure(error);

    }];

    
}

@end
