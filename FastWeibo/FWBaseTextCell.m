//
//  FWBaseTextCell.m
//  FastWeibo
//
//  Created by Bill Clock on 14-4-25.
//  Copyright (c) 2014年 Bill Clock. All rights reserved.
//  Cell根父类

#import "FWBaseTextCell.h"
#import "FWAvatar.h"
#import "FWBaseTextCellFrame.h"
#import "StatusModel.h"

@interface FWBaseTextCell()
{
    FWAvatar         *_avata;        // 头像
    UILabel         *_screenName;   // 昵称
    UIImageView     *_mbIcon;       // 会员图标
    UILabel         *_time;         // 时间
    UILabel         *_source;       // 来源
    UILabel         *_text;         // 正文
}
@end

@implementation FWBaseTextCell

#pragma mark - 1、初始化
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 1、基本设置
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        
        // 2、添加子控件
        [self creatSubView];
        
    }
    return self;
}

#pragma mark - 2、创建子控件
-(void)creatSubView
{
    // 1、头像
    _avata = [[FWAvatar alloc] init];
    _avata.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_avata];
    
    // 2、昵称
    _screenName = [[UILabel alloc] init];
    _screenName.backgroundColor = [UIColor clearColor];
    _screenName.font = kScreenNameFont;
    [self.contentView addSubview:_screenName];
    
    // 3、会员图标
    _mbIcon = [[UIImageView alloc] init];
    _mbIcon.image = [UIImage imageNamed:@"common_icon_membership.png"];
    [self.contentView addSubview:_mbIcon];
    
    // 4、时间
    _time = [[UILabel alloc] init];
    _time.backgroundColor = [UIColor clearColor];
    _time.font = kTimeFont;
    _time.textColor = kTimeColor;
    [self.contentView addSubview:_time];
    
    // 4、来源
    _source = [[UILabel alloc] init];
    _source.backgroundColor = [UIColor clearColor];
    _source.font = kSourceFont;
    _source.textColor = [UIColor grayColor];
    [self.contentView addSubview:_source];
    
    // 5、正文
    _text = [[UILabel alloc] init];
    _text.backgroundColor = [UIColor clearColor];
    _text.font = kTextFount;
    _text.numberOfLines = 0;
    [self.contentView addSubview:_text];
}

#pragma mark - 3、设置子控件
-(void)setCellFrame:(FWBaseTextCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    // 设置内容
    [self settingSubViewForContent];
    // 设置Frame
    [self settingSubViewForFrame];
    
}

#pragma mark 3.1、设置子控件内容
- (void)settingSubViewForContent
{
    
    // 1、设置头像
    [_avata setUser:_cellFrame.dataModel.user ofType:FWAvatarTypeSmall];
    
    // 2、设置昵称
    _screenName.text = _cellFrame.dataModel.user.screenName;
//    if (_cellFrame.dataModel.user.mbtype == kMbTypeNone) {
//        _screenName.textColor = kScreenNameColor;
//    } else {
//        _screenName.textColor = kMBScreenNameColor;
//    }
    
    // 3 设置会员图标
//    if (_cellFrame.dataModel.user.verified) {
//        _mbIcon.hidden = NO;
//    } else {
//        _mbIcon.hidden = YES;
//    }
    
    // 4、设置时间
    _time.text = _cellFrame.dataModel.createdAtWithFormat;
    
    // 5、设置来源
    _source.text = _cellFrame.dataModel.sourceWithFormat;
    
    // 6、设置正文
    _text.text = _cellFrame.dataModel.text;
}

#pragma mark 3.2、设置子控件Frame
- (void)settingSubViewForFrame
{
    // 1、设置头像尺寸位置
    _avata.frame = _cellFrame.avatarRect;
    
    // 2、设置昵称尺寸位置
    _screenName.frame = _cellFrame.screenNameRect;
    
    // 3、设置会员图标尺寸位置
    _mbIcon.frame = _cellFrame.mbIconRect;
    
    // 4、设置时间尺寸位置
    CGRect timeFrame =  _cellFrame.timeRect;
    timeFrame.size = [_cellFrame.dataModel.createdAtWithFormat sizeWithAttributes:@{NSFontAttributeName: kTimeFont}];
    _time.frame = timeFrame;
    
    // 5、设置来源尺寸位置
    CGRect sourceFrame = _cellFrame.sourceRect;
    sourceFrame.origin.x = CGRectGetMaxX(timeFrame) + kInterval;
    _source.frame = sourceFrame;
    
    // 6、设置正文尺寸位置
    _text.frame = _cellFrame.textRect;
}

#pragma mark - 4、设置Cell标识
+(NSString *)ID
{
    return @"BaseTextCell";
}

@end
