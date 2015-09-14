//
//  WeiboAccountManager.m
//  FastWeibo
//
//  Created by Bill Clock on 15/1/11.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "WeiboAccountManager.h"
#import "WeiboAccount.h"

#define kAccountFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)[0] stringByAppendingString:@"/account.data"]

@implementation WeiboAccountManager


+ (instancetype)sharedManager {
    static WeiboAccountManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[WeiboAccountManager alloc] init];

    });
    
    return _sharedManager;
}

- (id)init
{
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountFile];
    }
    return self;
}

- (void)saveAccount:(WeiboAccount *)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountFile];
}

- (BOOL)isNeedToRefreshToken
{
    NSDate *expiresDate = _account.expiresDate;
    if (expiresDate == nil) {
        return YES;
    }
    
    return !(NSOrderedDescending == [expiresDate compare:[NSDate date]]);
}
@end
