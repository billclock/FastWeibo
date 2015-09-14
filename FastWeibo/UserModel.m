//
//  UserModel.m
//  FastWeibo
//
//  Created by Bill Clock on 15/1/22.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "UserModel.h"
#import "StatusModel.h"

@implementation UserModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"userId" : @"id",
             @"screenName" : @"screen_name",
             @"profileImageUrl" : @"profile_image_url",
             @"gender" : @"gender",
             @"verified" : @"verified"
             };
}

+ (NSString *)managedObjectEntityName {
    return @"UserManagedObject";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return nil;
}

@end
