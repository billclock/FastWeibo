//
//  FWBaseCell.m
//  FastWeibo
//
//  Created by Bill Clock on 14-4-23.
//  Copyright (c) 2014年 Bill Clock. All rights reserved.
//  微博类Cell父类
//

#import "FWBaseStatusCell.h"
#import "StatusModel.h"
#import "UIImage+Ext.h"
#import "FWHomeStatusCellFrame.h"
#import "FWImageListView.h"

@interface FWBaseStatusCell ()
{
    FWImageListView *_image;        // 配图
    UIImageView     *_retweet;      // 转发体视图
    UILabel         *_reScreenName; // 转发体昵称
    UILabel         *_reText;       // 转发体正文
    FWImageListView *_reImage;      // 转发体配图
}
@end

@implementation FWBaseStatusCell

@dynamic cellFrame;

#pragma mark - 1、初始化
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImage *BGView = [UIImage resizeImage:@"common_card_background.png"];
        self.backgroundView = [[UIImageView alloc] initWithImage:BGView];
        
        UIImage *selectedBGView = [UIImage resizeImage:@"common_card_background_highlighted.png"];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:selectedBGView];
        
        [self creatBAseStatusSubView];
        
    }
    return self;
}

#pragma mark - 2、创建子控件
- (void)creatBAseStatusSubView
{
    // 1、配图
    _image = [[FWImageListView alloc] init];
    _image.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_image];
    
    // 2、转发体视图
    _retweet = [[UIImageView alloc] init];
    NSString *imageName = @"timeline_retweet_background.png";
    _retweet.image = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:25 topCapHeight:10];
    _retweet.userInteractionEnabled = YES;
    [self.contentView addSubview:_retweet];
    
    // 3、转发体昵称
    _reScreenName = [[UILabel alloc] init];
    _reScreenName.font = kReScreenNameFont;
    _reScreenName.backgroundColor = [UIColor clearColor];
    _reScreenName.textColor = [UIColor blueColor];
    [_retweet addSubview:_reScreenName];
    
    // 4、转发体正文
    _reText = [[UILabel alloc] init];
    _reText.numberOfLines = 0;
    _reText.font = kReTextFont;
    _reText.backgroundColor = [UIColor clearColor];
    [_retweet addSubview:_reText];
    
    // 5、转发体配图
    _reImage = [[FWImageListView alloc] init];
    _reImage.contentMode = UIViewContentModeScaleAspectFit;
    [_retweet addSubview:_reImage];
}

#pragma mark - 3、设置子控件
-(void)setCellFrame:(FWBaseStatusCellFrame *)cellFrame
{
    
    [super setCellFrame:cellFrame];
    
    // 1、设置子控件内容
    [self settingBaseStatusSubViewContent];
    
    // 2、计算子控件Frame
    [self settingBaseStatusSubViewFrame];
}

#pragma mark 3.1、设置子控件内容
- (void)settingBaseStatusSubViewContent
{
    StatusModel *status = self.cellFrame.dataModel;
    
    // 1、设置配图
    if (status.picUrls.count) {                                 // 第一种情况：带有配图的微博
        
        _image.hidden = NO;
        _retweet.hidden = YES;
        
        _image.imageList = status.picUrls;
        
    } else if (status.retweetedStatus) {                        // 第二种情况：转发的微博
        
        _image.hidden = YES;
        _retweet.hidden = NO;
        
        // 2、设置转发体昵称
        _reScreenName.text = [NSString stringWithFormat:@"@%@", status.retweetedStatus.user.screenName];
        
        // 3、转发体正文
        _reText.text = status.retweetedStatus.text;
        
        // 4、转发体配图
        if (status.retweetedStatus.picUrls.count) {             // 第二种情况：1、转发的微博带配图
            
            _reImage.hidden = NO;
            _reImage.imageList = status.retweetedStatus.picUrls;
            
        } else {                                                // 第二种情况：2、转发的微博不带配图
            
            // 无配图则不显示
            _reImage.hidden = YES;
        }
        
    } else {                                                    // 第三种情况：不带配图的微博
        
        _image.hidden = YES;
        _retweet.hidden = YES;
    }
    
}

#pragma mark 3.2、设置子控件Frame
- (void)settingBaseStatusSubViewFrame
{
    
    // 1、设置配图尺寸位置
    _image.frame = self.cellFrame.image;
    
    // 2、设置转发体尺寸位置
    _retweet.frame = self.cellFrame.retweet;
    
    // 3、设置转发体昵称尺寸位置
    _reScreenName.frame = self.cellFrame.reScreenName;
    
    // 4、转发体正文尺寸位置
    _reText.frame = self.cellFrame.reText;
    
    // 5、转发体配图尺寸位置
    _reImage.frame = self.cellFrame.reImage;
    
}

#pragma mark - 4、重写frame方法设置Cell宽度
-(void)setFrame:(CGRect)frame
{
    frame.origin.x += kCellMargins;
    frame.size.width -= (2 *kCellMargins);
    frame.origin.y += kCellMargins;
    frame.size.height -= kCellMargins;
    
    [super setFrame:frame];
}

#pragma mark - 5、设置Cell标识
+(NSString *)ID
{
    return @"BaseStatusCell";
}

@end