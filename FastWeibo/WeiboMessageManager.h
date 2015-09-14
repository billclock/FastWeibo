//
//  WeiboMessageManager.h
//  FastWeibo
//
//  Created by Bill Clock on 15/1/13.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^StatusSuccess)(NSArray * array);
typedef void(^StatusFailure)(NSError * error);

@interface WeiboMessageManager : NSObject

+ (instancetype)sharedManager;
- (void)getHomeLineWithSinceID:(int64_t)sinceID maxID:(int64_t)maxID count:(int)count page:(int)page baseApp:(int)baseApp feature:(int)feature success:(StatusSuccess)success failure:(StatusFailure)failure;
@end
