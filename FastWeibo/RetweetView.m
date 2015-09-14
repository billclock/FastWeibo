//
//  RetweetView.m
//  FastWeibo
//
//  Created by Bill Clock on 15/4/10.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "RetweetView.h"
#import "FWImageListView.h"

@interface RetweetView ()
{
//    UILabel         *_reScreenName; // 转发体昵称
//    UILabel         *_reText;       // 转发体正文
//    FWImageListView *_reImage;      // 转发体配图
}
@end

@implementation RetweetView

//- (void)awakeFromNib
//{
//    NSString *imageName = @"timeline_retweet_background.png";
//    self.image = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:25 topCapHeight:10];
//    self.userInteractionEnabled = YES;
//    
//    // 3、转发体昵称
//    _reScreenName = [[UILabel alloc] init];
//    _reScreenName.font = kReScreenNameFont;
//    _reScreenName.backgroundColor = [UIColor clearColor];
//    _reScreenName.textColor = [UIColor blueColor];
//    [self addSubview:_reScreenName];
//    
//    // 4、转发体正文
//    _reText = [[UILabel alloc] init];
//    _reText.numberOfLines = 0;
//    _reText.font = kReTextFont;
//    _reText.backgroundColor = [UIColor clearColor];
//    [self addSubview:_reText];
//    
//    // 5、转发体配图
//    _reImage = [[FWImageListView alloc] init];
//    _reImage.contentMode = UIViewContentModeScaleAspectFit;
//    [self addSubview:_reImage];
//
//
//}

- (CGSize)intrinsicContentSize
{
    if (self.hidden) {
        return CGSizeZero;
    } else {
        return [super intrinsicContentSize];
    }
}

@end
