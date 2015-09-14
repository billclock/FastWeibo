//
//  UserModel.h
//  FastWeibo
//
//  Created by Bill Clock on 15/1/22.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import <Mantle/Mantle.h>

@class StatusModel;

@interface UserModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>
// 返回值字段	字段类型	字段说明
// id	int64	用户UID
@property (nonatomic, assign) int64_t userId;

// screen_name	string	用户昵称
@property (nonatomic, strong) NSString *screenName;

// profile_image_url	string	用户头像地址（中图），50×50像素
@property (nonatomic, strong) NSString *profileImageUrl;

// gender	string	性别，m：男、f：女、n：未知
@property (nonatomic, strong) NSString *gender;

// verified	boolean	是否是微博认证用户，即加V用户，true：是，false：否
@property (nonatomic, assign) BOOL verified;



@end
