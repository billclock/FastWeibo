//
//  StatusModel.m
//  FastWeibo
//
//  Created by Bill Clock on 15/1/21.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "StatusModel.h"
#import "UserModel.h"
#import "PicUrlModel.h"

@implementation StatusModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"statusId" : @"id",
             @"createdAt" : @"created_at",
             @"text" : @"text",
             @"source" : @"source",
             @"favorited" : @"favorited",
             @"truncated" : @"truncated",
             @"retweetedStatus" : @"retweeted_status",
             @"user" : @"user",
             @"repostsCount" : @"reposts_count",
             @"commentsCount" : @"comments_count",
             @"attitudesCount" : @"attitudes_count",
             @"picUrls" : @"pic_urls",
             @"isTimeLine" : NSNull.null
             };
}


+ (NSValueTransformer *)retweetedStatusJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:StatusModel.class];
}

+ (NSValueTransformer *)userJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:UserModel.class];
}

+ (NSValueTransformer *)picUrlsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:PicUrlModel.class];
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return nil;
}

+ (NSString *)managedObjectEntityName {
    return @"StatusManagedObject";
}

+(NSDictionary *)relationshipModelClassesByPropertyKey{
    return @{
             @"user" : UserModel.class,
             @"retweetedStatus" : StatusModel.class,
             @"picUrls"  : PicUrlModel.class,
             
             };
}

// Core Data 存成 NSSet 需要再转换成NSArray
- (void)setPicUrls:(NSArray *)picUrls
{
    if ([picUrls isKindOfClass:NSSet.class]) {
        _picUrls = [((NSSet *)picUrls) allObjects];
    } else {
        _picUrls = picUrls;
    }
}

- (NSString *)createdAtWithFormat
{
    // 取出数据结构为: Sat Apr 19 19:15:53 +0800 2014，将数据格式化输出业务数据
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    dfm.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    dfm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 格式取出的字符串，获取时间对象
    NSDate *createdTime = [dfm dateFromString:_createdAt];
    dfm.dateFormat = @"M月d日 HH点mm分";
    
    // 时间格式化成字符串
    NSString *createdTimeStr = [dfm stringFromDate:createdTime];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:createdTime];
    NSTimeInterval second = time;       // 时间单位换算成 秒
    NSTimeInterval minute = time / 60;  // 时间单位换算成 分
    NSTimeInterval hour = minute / 60;  // 时间单位换算成 时
    NSTimeInterval day = hour / 24;     // 时间单位换算成 天
    NSTimeInterval year = day / 365;    // 时间单位换算成 年
    
    if (second < 60) {                  // 1分钟之内显示 "刚刚"
        return @"刚刚";
    } else if (minute < 60) {           // 1小时之内显示 "x分钟前"
        return [NSString stringWithFormat:@"%.f分钟前", minute];
    } else if (hour < 24) {             // 1天之内显示 "x小时前"
        return [NSString stringWithFormat:@"%.f小时前", hour];
    } else if (day < 7) {               // 1周之内显示 "x天前"
        return [NSString stringWithFormat:@"%.f天前", day];
    } else if (year >= 1) {             // 1年以前显示 "xxxx年x月x日"
        dfm.dateFormat = @"yyyy年M月d日";
        return [dfm stringFromDate:createdTime];
    } else {                            // 1年以内显示 "x月x日 x点x分"
        return createdTimeStr;
    }
}

- (NSString *)sourceWithFormat
{
    // 源source结构为: <a href="http://app.weibo.com/t/feed/4ACxed" rel="nofollow">iPad客户端</a>
    NSInteger begin = [_source rangeOfString:@">"].location + 1;
    NSInteger end = [_source rangeOfString:@"</a>"].location;
    NSString *tempStr = [_source substringWithRange:NSMakeRange(begin, end - begin)];
    
    // 从字符串取出"iPad客户端"再在前面拼接"来自"
    return [NSString stringWithFormat:@"来自 %@", tempStr];
}

@end
