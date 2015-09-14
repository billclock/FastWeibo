//
//  WeiboAccount.h
//  FastWeibo
//
//  Created by Bill Clock on 15/1/11.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboAccount : NSObject

@property (nonatomic, copy) NSString    *accessToken;
@property (nonatomic, copy) NSDate      *expiresDate;
@property (nonatomic, copy) NSString    *uid;

- (id)initWithDict:(NSDictionary *)dict;

+ (id)accountWithDict:(NSDictionary *)dict;
@end
