//
//  FWBaseStatusCell.h
//  FastWeibo
//
//  Created by Bill Clock on 14-4-23.
//  Copyright (c) 2014年 Bill Clock. All rights reserved.
//  微博类Cell父类
//

#import "FWBaseTextCell.h"
#import "FWBaseStatusCellFrame.h"

@interface FWBaseStatusCell : FWBaseTextCell

@property (nonatomic, strong) FWBaseStatusCellFrame *cellFrame;     // 框架模型
@property (nonatomic, strong) UIImageView           *retweet;       // 转发体视图

@end
