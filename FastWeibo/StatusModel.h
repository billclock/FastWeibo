//
//  StatusModel.h
//  FastWeibo
//
//  Created by Bill Clock on 15/1/21.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import  <Mantle/Mantle.h>

@class UserModel;

@interface StatusModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

// id	int64	微博ID
@property (nonatomic, assign) int64_t statusId;

// created_at	string	微博创建时间
@property (nonatomic, strong) NSString *createdAt;

// text	string	微博信息内容
@property (nonatomic, strong) NSString *text;

// source	string	微博来源
@property (nonatomic, strong) NSString *source;

// favorited	boolean	是否已收藏，true：是，false：否
@property (nonatomic, assign) BOOL favorited;

// truncated	boolean	是否被截断，true：是，false：否
@property (nonatomic, assign) BOOL truncated;

// user	object	微博作者的用户信息字段 详细
@property (nonatomic, strong) UserModel *user;

// retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
@property (nonatomic, strong) StatusModel *retweetedStatus;

// reposts_count	int	转发数
@property (nonatomic, assign) NSInteger repostsCount;

// comments_count	int	评论数
@property (nonatomic, assign) NSInteger commentsCount;

// attitudes_count	int	表态数
@property (nonatomic, assign) NSInteger attitudesCount;

// pic_ids	object	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
@property (nonatomic, strong) NSArray *picUrls;

@property (nonatomic, assign) BOOL isTimeLine;

- (NSString *)createdAtWithFormat;
- (NSString *)sourceWithFormat;

@end
