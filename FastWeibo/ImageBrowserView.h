//
//  ImageBrowserView.h
//  FastWeibo
//
//  Created by Bill Clock on 15/9/8.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWImageListView.h"
#import "ImageZoomScrollView.h"

@interface ImageBrowserView : UIView

@property (nonatomic, strong) UIScrollView *imagesScrollView;
@property (nonatomic, strong) ImageZoomScrollView *curImgZoomScrollView;

- (void)addSubImageViewByImgListView:(FWImageListView *)imgListView currentIndex:(NSUInteger) currentIndex;
- (void)playShowAnimation;

@end
