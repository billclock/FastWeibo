//
//  ImageBrowserView.m
//  FastWeibo
//
//  Created by Bill Clock on 15/9/8.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "ImageBrowserView.h"
#import "FWImageView.h"
#import "ImageZoomScrollView.h"

@interface ImageBrowserView() <UIScrollViewDelegate>
{
    NSUInteger currentIndex;
}

@end

@implementation ImageBrowserView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imagesScrollView =  [[UIScrollView alloc] initWithFrame:frame];
        self.imagesScrollView.pagingEnabled = YES;
        self.imagesScrollView.delegate = self;
        [self addSubview: self.imagesScrollView];
        
        self.alpha = 0.0f;
        self.backgroundColor = [UIColor blackColor];

        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackground:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)addSubImageViewByImgListView:(FWImageListView *)imgListView currentIndex:(NSUInteger) curIndex
{
    for (UIView *view in _imagesScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    currentIndex = curIndex;
    
    CGSize contentSize = self.imagesScrollView.contentSize;
    contentSize.height = self.bounds.size.height;
    contentSize.width = self.bounds.size.width * imgListView.imageList.count;
    self.imagesScrollView.contentSize = contentSize;
    
    CGPoint contentOffset = self.imagesScrollView.contentOffset;
    contentOffset.x = currentIndex * self.bounds.size.width;
    self.imagesScrollView.contentOffset = contentOffset;
    
    for (NSUInteger i = 0; i < imgListView.imageList.count; i ++) {
        FWImageView *tmpView = (FWImageView *)[imgListView viewWithTag:(10 + i)];
        CGRect convertRect = [tmpView convertRect:tmpView.bounds toView:self];

        ImageZoomScrollView *tmpImgScrollView = [[ImageZoomScrollView alloc] initWithFrame:CGRectMake(                                                 self.bounds.size.width * i, 0,  self.bounds.size.width, self.bounds.size.height)];
        
        [tmpImgScrollView saveOldFrame:convertRect];
        [tmpImgScrollView setImageUrl:tmpView.picUrl];
        
        [self.imagesScrollView addSubview:tmpImgScrollView];
        
        if (i != currentIndex) {
            [tmpImgScrollView setNewFrame];
        } else {
            self.curImgZoomScrollView = tmpImgScrollView;
            [self.curImgZoomScrollView setOldFrame];
        }
    }
    
}

- (void)playShowAnimation
{
    self.hidden = NO;
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1;
        [self.curImgZoomScrollView setNewFrame];
    }];
}

- (void)tappedBackground:(UITapGestureRecognizer*)tap
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.curImgZoomScrollView setOldFrame];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

#pragma mark - scroll delegate
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    currentIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

@end
