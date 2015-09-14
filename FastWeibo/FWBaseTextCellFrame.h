//
//  FWBaseTextCellFrame.h
//  FastWeibo
//
//  Created by Bill Clock on 14-4-25.
//  Copyright (c) 2014年 Bill Clock. All rights reserved.
//  Cell根父类框架模型

#import <Foundation/Foundation.h>
#import "FWAvatar.h"

@class StatusModel;

@interface FWBaseTextCellFrame : NSObject

@property (nonatomic, readonly) CGRect      avatarRect;      // 头像
@property (nonatomic, readonly) CGRect      screenNameRect; // 昵称
@property (nonatomic, readonly) CGRect      mbIconRect;     // 会员图标
@property (nonatomic, assign)   CGRect      timeRect;       // 时间
@property (nonatomic, assign)   CGRect      sourceRect;     // 来源
@property (nonatomic, assign)   CGRect      textRect;       // 正文
@property (nonatomic, assign)   CGFloat     cellHeight;     // 行高
@property (nonatomic, readonly) CGFloat     cellWidth;      // 行宽
@property (nonatomic, assign)   FWAvatarType avatarType;      // 头像类型
@property (nonatomic, strong)   StatusModel  *dataModel;     // 数据模型

-(void)setDataModel:(StatusModel *)dataModel withAvatarType:(FWAvatarType)avatarType;

@end
