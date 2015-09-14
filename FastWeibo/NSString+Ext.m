//
//  NSString+Ext.m
//  FastWeibo
//
//  Created by Bill Clock on 15/3/22.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString (Ext)
- (NSString *)fileAppend:(NSString *)string
{
    // 1、获取文件扩展名
    NSString *ext = [self pathExtension];
    
    // 2、去掉文件扩展名
    NSString *str = [self stringByDeletingPathExtension];
    
    // 3、拼接新加字符串
    str = [str stringByAppendingString:string];
    
    // 4、拼接扩展名
    str = [str stringByAppendingPathExtension:ext];
    
    return str;
    
}
@end
