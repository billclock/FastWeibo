//
//  WeiboAppManager.h
//  FastWeibo
//
//  Created by Bill Clock on 15/3/1.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusesFetcher.h"

@interface WeiboAppManager : NSObject <StatusesFetcher>

+ (WeiboAppManager *)sharedManager;

@end
