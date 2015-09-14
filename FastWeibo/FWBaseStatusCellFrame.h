//
//  FWBaseStatusCellFrame.h
//  FastWeibo
//
//  Created by Bill Clock on 14-4-23.
//  Copyright (c) 2014年 Bill Clock. All rights reserved.
//

#import "FWBaseTextCellFrame.h"
#import "StatusModel.h"

@interface FWBaseStatusCellFrame : FWBaseTextCellFrame
{
    CGRect      _retweet;           // 转发体Frame
}

@property (nonatomic, readonly) CGRect      image;          // 配图
@property (nonatomic, readonly) CGRect      retweet;        // 转发体视图
@property (nonatomic, readonly) CGRect      reScreenName;   // 转发体昵称
@property (nonatomic, readonly) CGRect      reText;         // 转发体正文
@property (nonatomic, readonly) CGRect      reImage;        // 转发体配图


@end
