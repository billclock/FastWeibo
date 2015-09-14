//
//  FWAvatar.m
//  FastWeibo
//
//  Created by Bill Clock on 14-4-19.
//  Copyright (c) 2014年 Bill Clock. All rights reserved.
//  用户头像处理类
//

#import "FWAvatar.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FWAvatar ()
{
    UIImageView *_icon;
    UIImageView *_verified;
}
@end

@implementation FWAvatar

#pragma mark - 1、初始化
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        // 1、设置头像
        _icon = [[UIImageView alloc] init];
        [self addSubview:_icon];
        
        // 2、设置认证图标
        _verified = [[UIImageView alloc] init];
        [self addSubview:_verified];
        
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1、设置头像
        _icon = [[UIImageView alloc] init];
        [self addSubview:_icon];
        
        // 2、设置认证图标
        _verified = [[UIImageView alloc] init];
        [self addSubview:_verified];
        
    }
    return self;
}


#pragma mark - 2、设置用户数据及头像尺寸
- (void)setUser:(UserModel *)user ofType:(FWAvatarType)type
{
    [self setUser:user];
    [self setType:type];
}

#pragma mark 2.1、设置用户头像尺寸位置
-(void)setType:(FWAvatarType)type
{
    _type = type;
    
    // 1、设置头像尺寸位置
    // 2、设置认证图标尺寸位置
    
    switch (type) {
        case FWAvatarTypeSmall:
            
            _icon.frame =  CGRectMake(0, 0, kAvatarSmallW, kAvatarSmallH);
            _verified.center = (CGPoint){_icon.frame.size.width, _icon.frame.size.height};
            _verified.bounds = CGRectMake(0, 0, kVerifiedW, kVerifiedH);
            break;
            
        case FWAvatarTypeBig:
            
            _icon.frame =  CGRectMake(0, 0, kAvatarBigW, kAvatarBigH);
            _verified.center = (CGPoint){_icon.frame.size.width, _icon.frame.size.height};
            _verified.bounds = CGRectMake(0, 0, kVerifiedW, kVerifiedH);
            break;
            
        default:
            
            _icon.frame =  CGRectMake(0, 0, kAvatarDefaultW, kAvatarDefaultH);
            _verified.center = (CGPoint){_icon.frame.size.width, _icon.frame.size.height};
            _verified.bounds = CGRectMake(0, 0, kVerifiedW, kVerifiedH);
            break;
    }
    
}

#pragma mark 2.2、设置用户数据
-(void)setUser:(UserModel *)user
{
    // 1、设置头像图标内容
    _user = user;
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default.png"]];
    
    // 2、设置认证图标内容
    if (user.verified) {
        _verified.hidden = NO;
        _verified.image = [UIImage imageNamed:@"avatar_vip.png"];
    } else {
        _verified.hidden = YES;
    }
    
    
}

#pragma mark - 3、对外提供获取对象数据的方法

#pragma mark 3.1、提供用户头像占位图
- (UIImage *)placeImageWithAvatarType:(FWAvatarType)avataType
{
    switch (avataType) {
        case FWAvatarTypeSmall:
            
            return [UIImage imageNamed:@"avatar_default_small.png"];
            break;
            
        case FWAvatarTypeBig:
            
            return [UIImage imageNamed:@"avatar_default_big.png"];
            break;
            
        default:
            
            return [UIImage imageNamed:@"avatar_default.png"];
            break;
    }
}

#pragma mark 3.2、提供不同类型头像的尺寸
+ (CGSize)sizeOfAvatarType:(FWAvatarType)avatarType
{
    switch (avatarType) {
        case FWAvatarTypeSmall:
            
            return CGSizeMake(kAvatarSmallW + kVerifiedW * 0.5, kAvatarSmallH + kVerifiedH * 0.5);
            break;
            
        case FWAvatarTypeDefault:
            
            return CGSizeMake(kAvatarDefaultW + kVerifiedW * 0.5, kAvatarDefaultH + kVerifiedH * 0.5);
            break;
            
        case FWAvatarTypeBig:
            
            return CGSizeMake(kAvatarBigW + kVerifiedW * 0.5, kAvatarBigH + kVerifiedH * 0.5);
            break;
    }
}

@end
