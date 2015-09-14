//
//  WeiboAccount.m
//  FastWeibo
//
//  Created by Bill Clock on 15/1/11.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "WeiboAccount.h"

@implementation WeiboAccount

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.uid = dict[@"uid"];
        self.accessToken = dict[@"access_token"];
        NSInteger expiresInValue = [dict[@"expires_in"] integerValue];
        self.expiresDate = [[NSDate alloc] initWithTimeIntervalSinceNow:expiresInValue];
        NSLog(@"expiresDate = %@", self.expiresDate);
    }
    return self;
}

+ (id)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_accessToken forKey:@"accessToken"];
    [aCoder encodeObject:_expiresDate forKey:@"expiresDate"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.expiresDate = [aDecoder decodeObjectForKey:@"expiresDate"];
    }
    
    return self;
}

@end

