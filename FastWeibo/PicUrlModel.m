//
//  PicUrlModel.m
//  FastWeibo
//
//  Created by Bill Clock on 15/2/9.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "PicUrlModel.h"

@implementation PicUrlModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"thumbnailPic" : @"thumbnail_pic",
             };
}


+ (NSString *)managedObjectEntityName {
    return @"PicUrlManagedObject";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return nil;
}

@end
