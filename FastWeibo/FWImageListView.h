//
//  FWImageListView.h
//  FastWeibo
//
//  Created by Bill Clock on 14-4-19.
//  Copyright (c) 2014年 Bill Clock. All rights reserved.
//  微博配图处理类

#import <UIKit/UIKit.h>


@interface FWImageListView : UIView

@property (nonatomic, strong) NSArray *imageList;

+ (CGSize)sizeOfViewWithImageCount:(NSInteger)count;

@end
