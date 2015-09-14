//
//  WeiboAccountManager.h
//  FastWeibo
//
//  Created by Bill Clock on 15/1/11.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboAccount.h"

@interface WeiboAccountManager : NSObject

@property (nonatomic, readonly) WeiboAccount *account;

+ (WeiboAccountManager *)sharedManager;

- (void)saveAccount:(WeiboAccount *)account;
- (BOOL)isNeedToRefreshToken;

@end
