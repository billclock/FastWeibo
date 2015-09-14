//
//  FWAvatar.h
//  FastWeibo
//
//  Created by Bill Clock on 14-4-19.
//  Copyright (c) 2014年 Bill Clock. All rights reserved.
//  用户头像处理类
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

typedef NS_ENUM(NSInteger, FWAvatarType) {
    
    FWAvatarTypeSmall,    // 小图标：36 * 36
    FWAvatarTypeDefault,  // 中图标：50 * 50
    FWAvatarTypeBig       // 大图标：85 * 85
};

@interface FWAvatar : UIView

@property (nonatomic, assign) FWAvatarType   type;
@property (nonatomic, strong) UserModel     *user;

+ (CGSize)sizeOfAvatarType:(FWAvatarType)avataType;
- (void)setUser:(UserModel *)user ofType:(FWAvatarType)type;
- (UIImage *)placeImageWithAvatarType:(FWAvatarType)avataType;

@end
