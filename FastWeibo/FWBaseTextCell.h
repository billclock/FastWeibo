//
//  FWBaseTextCell.h
//  FastWeibo
//
//  Created by Bill Clock on 14-4-25.
//  Copyright (c) 2014年 Bill Clock. All rights reserved.
//  Cell根父类
//

#import <UIKit/UIKit.h>
@class FWBaseTextCellFrame;

@interface FWBaseTextCell : UITableViewCell

@property (nonatomic, strong) FWBaseTextCellFrame *cellFrame;

+ (NSString *)ID;

@end
