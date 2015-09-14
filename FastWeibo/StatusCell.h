//
//  StatusCell.h
//  FastWeibo
//
//  Created by Bill Clock on 15/3/22.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusModel;
@class FWAvatar;
@class FWImageListView;

@interface StatusCell : UITableViewCell

+ (NSString *) indentifier;
-(void)setStatusModel:(StatusModel *)statusModel;

@end
