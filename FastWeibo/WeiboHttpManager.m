//
//  WeiboHttpManager.m
//  FastWeibo
//
//  Created by Bill Clock on 15/1/11.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "WeiboHttpManager.h"
#import "Constants.h"

@implementation WeiboHttpManager

+ (instancetype)sharedManager {
    static WeiboHttpManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[WeiboHttpManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        _sharedManager.responseSerializer.acceptableContentTypes = [_sharedManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    });
    
    return _sharedManager;
}

@end
