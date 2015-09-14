//
//  FWBaseTextCellFrame.m
//  FastWeibo
//
//  Created by Bill Clock on 14-4-25.
//  Copyright (c) 2014年 Bill Clock. All rights reserved.
//  Cell根父类框架模型

#import "FWBaseTextCellFrame.h"
#import "StatusModel.h"

@implementation FWBaseTextCellFrame

#pragma mark - 设置数据模型计算框架模型（头像大小默认为small）
-(void)setDataModel:(StatusModel *)dataModel
{
    _dataModel = dataModel;
    CGSize screenSize = [UIScreen mainScreen].applicationFrame.size;
    _cellWidth = screenSize.width - 2 * kCellMargins;
    
    // 1、设置头像尺寸位置；
    CGFloat avatarX = kInterval;
    CGFloat avatarY = kInterval;
    _avatarRect = (CGRect){{avatarX, avatarY}, [FWAvatar sizeOfAvatarType:_avatarType]};
    
    // 2、设置昵称尺寸位置；
    CGFloat screenNameX = CGRectGetMaxX(_avatarRect) + kInterval;
    CGFloat screenNameY = avatarY;
    CGSize screenNameSize = [dataModel.user.screenName sizeWithAttributes:@{NSFontAttributeName : kScreenNameFont}];
    _screenNameRect = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    // 3、设置会员图标尺寸位置
    CGFloat mbIconX = CGRectGetMaxX(_screenNameRect) + kInterval;
    CGFloat mbIconY = (screenNameSize.height - kMBIconWH) * 0.5 + screenNameY;
    _mbIconRect = CGRectMake(mbIconX, mbIconY, kMBIconWH, kMBIconWH);
    
    // 4、默认高度
    _cellHeight = MAX(CGRectGetHeight(_avatarRect), CGRectGetHeight(_screenNameRect)) + kInterval;
}

#pragma mark - 根据头像大小设置数据模型计算框架模型
-(void)setDataModel:(StatusModel *)dataModel withAvatarType:(FWAvatarType)avatarType
{
    _avatarType = avatarType;
    [self setDataModel:dataModel];
}

@end
