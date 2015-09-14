//
//  ImageZoomScrollView.m
//  FastWeibo
//
//  Created by Bill Clock on 15/9/9.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "ImageZoomScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ImageZoomScrollView() <UIScrollViewDelegate>
{
    UIImageView *imgView;
    CGRect      originScaleRect;
    CGRect      oldRect;
    CGSize      imgSize;
    
}
@end

@implementation ImageZoomScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.backgroundColor = [UIColor clearColor];
        self.minimumZoomScale = 1.0;
        self.delegate = self;
        
        imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:imgView];
        
    }
    return self;
}


- (void) saveOldFrame:(CGRect) rect
{
    oldRect = rect;
}

- (void) setNewFrame
{
    imgView.frame = originScaleRect;
}

- (void) setOldFrame
{
    self.zoomScale = 1.0;
    imgView.frame = oldRect;
}

- (void) setImageUrl: (NSString *)imgUrl
{
    if (imgUrl) {
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                imgSize = image.size;
                
                float scaleX = self.frame.size.width / imgSize.width;
                float scaleY = self.frame.size.height / imgSize.height;
                
                if (scaleX > scaleY)
                {
                    float imgViewWidth = imgSize.width * scaleY;
                    self.maximumZoomScale = self.frame.size.width / imgViewWidth;

                    originScaleRect = (CGRect){self.frame.size.width / 2 - imgViewWidth/2, 0,imgViewWidth, self.frame.size.height};
                }
                else
                {
                    float imgViewHeight = imgSize.height * scaleX;
                    self.maximumZoomScale = self.frame.size.height / imgViewHeight;
                    
                    originScaleRect = (CGRect){ 0, self.frame.size.height / 2 - imgViewHeight / 2,
                        self.frame.size.width, imgViewHeight };
                }
            }
           
        }];

    }
}


#pragma mark -
#pragma mark - scroll delegate
- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = imgView.frame;
    CGSize contentSize = scrollView.contentSize;
    
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    // center horizontally
    if (imgFrame.size.width <= boundsSize.width)
    {
        centerPoint.x = boundsSize.width/2;
    }
    
    // center vertically
    if (imgFrame.size.height <= boundsSize.height)
    {
        centerPoint.y = boundsSize.height/2;
    }
    
    imgView.center = centerPoint;
}

@end
