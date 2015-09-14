//
//  FWBaseDock.h
//  FastWeibo
//
//  Created by Bill Clock on 14-4-23.
//  Copyright (c) 2014年 Bill Clock. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusModel;

@interface FWBaseDock : UIImageView
{
    UIButton    *_reposts;
    UIButton    *_comments;
    UIButton    *_attitudes;
    StatusModel    *_status;
}

@property (nonatomic, strong) StatusModel *status;

- (UIButton *)addButtonWithImage:(NSString *)imageName backgroundImage:(NSString *)backgroundImageName buttonIndex:(NSInteger)index;

- (void)setButton:(UIButton *)button withTitle:(NSString *)title forCounts:(NSUInteger)number;

@end
