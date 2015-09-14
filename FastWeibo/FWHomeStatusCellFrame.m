//
//  FWHomeStatusCellFrame.m
//  FastWeibo
//
//  Created by Bill Clock on 14-4-18.
//  Copyright (c) 2014年 Bill Clock. All rights reserved.
//  数据框架模型

#import "FWHomeStatusCellFrame.h"

@implementation FWHomeStatusCellFrame

-(void)setDataModel:(StatusModel *)dataModel
{
    [super setDataModel:dataModel];
    
    self.cellHeight += kStatusDockHeight;
}

@end
