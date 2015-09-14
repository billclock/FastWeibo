//
//  UIImage+Ext.m
//  FastWeibo
//
//  Created by Bill Clock on 15/3/22.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "UIImage+Ext.h"

@implementation UIImage (Ext)

+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
}

@end
