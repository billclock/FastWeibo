//
//  Blocks.h
//  FastWeibo
//
//  Created by Bill Clock on 15/3/1.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//



typedef void (^CompletionBlock)(NSError *error);

typedef void (^BooleanCompletionBlock)(BOOL result, NSError *error);

typedef void (^ObjectCompletionBlock)(id object, NSError *error);

typedef void (^ArrayCompletionBlock)(NSArray *array, NSError *error);

