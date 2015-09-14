//
//  WeiboHttpManager.h
//  FastWeibo
//
//  Created by Bill Clock on 15/1/11.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>


@interface WeiboHttpManager : AFHTTPRequestOperationManager
+ (instancetype)sharedManager;
@end
