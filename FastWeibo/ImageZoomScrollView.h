//
//  ImageZoomScrollView.h
//  FastWeibo
//
//  Created by Bill Clock on 15/9/9.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageZoomScrollView : UIScrollView

- (void) saveOldFrame:(CGRect) rect;
- (void) setNewFrame;
- (void) setOldFrame;
- (void) setImageUrl: (NSString *)imgUrl;

@end
