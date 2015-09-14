//
//  StatusCell.m
//  FastWeibo
//
//  Created by Bill Clock on 15/3/22.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//  这个是用AutoLayout的版本，发现微博布局太复杂，AutoLayout没完美布局成功，改用代码方式实现
//

#import "StatusCell.h"
#import "UserModel.h"
#import "StatusModel.h"
#import "UIImage+Ext.h"
#import "NSString+Ext.h"
#import "FWAvatar.h"
#import "FWImageListView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface StatusCell ()

@property (weak, nonatomic) IBOutlet FWAvatar *avata;
@property (weak, nonatomic) IBOutlet FWImageListView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *textContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UIButton *repostsButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
@property (weak, nonatomic) IBOutlet UIButton *attitudesButton;
@property (weak, nonatomic) IBOutlet UIView *retweetView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetBg;
@property (weak, nonatomic) IBOutlet UILabel *reScreenName;
@property (weak, nonatomic) IBOutlet UILabel *reText;
//@property (weak, nonatomic) IBOutlet FWImageListView *reImageListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetHeight;

@end

@implementation StatusCell

- (void)awakeFromNib
{
    [self setButton:_commentsButton backgroundImage:@"timeline_card_leftbottom.png"];
    [self setButton:_repostsButton backgroundImage:@"timeline_card_middlebottom.png"];
    [self setButton:_attitudesButton backgroundImage:@"timeline_card_rightbottom.png"];
    
//    NSString *imageName = @"timeline_retweet_background.png";
//    _retweetBg.image = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:25 topCapHeight:10];
//    _retweetBg.userInteractionEnabled = YES;

}

- (void)setButton:(UIButton *)button backgroundImage:(NSString *)backgroundImageName
{
    [button setBackgroundImage:[UIImage resizeImage:backgroundImageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizeImage:[backgroundImageName fileAppend:@"_highlighted"]] forState:UIControlStateHighlighted];
}

- (void)setButton:(UIButton *)button withTitle:(NSString *)title forCounts:(NSUInteger)number
{
    if (number > 10000) {       // 一万条以上数据简约显示
        NSString *title = [NSString stringWithFormat:@"%.1f万", number / 10000.0];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [button setTitle:title forState:UIControlStateNormal];
    } else if(number > 0) {     // 一万条以下数据显示实际数值
        [button setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)number] forState:UIControlStateNormal];
    } else {                    // 数值为0则显示文字
        [button setTitle:title forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    [self.contentView layoutIfNeeded];
    _textContentLabel.preferredMaxLayoutWidth = CGRectGetWidth(_textContentLabel.frame);
    _reText.preferredMaxLayoutWidth = CGRectGetWidth(_reText.frame);

}

+ (NSString *) indentifier
{
    return @"StatusCell";
}



-(void)setStatusModel:(StatusModel *)statusModel
{
    [_avata setUser:statusModel.user ofType:FWAvatarTypeDefault];
    _screenNameLabel.text = statusModel.user.screenName;
    _createAtLabel.text = statusModel.createdAtWithFormat;
    _sourceLabel.text = statusModel.sourceWithFormat;
    _textContentLabel.text = statusModel.text;
    
    if (statusModel.picUrls) {
        _imageListView.imageList = statusModel.picUrls;
    } else {
        _imageListView.imageList = @[];
    }
    [_imageListView invalidateIntrinsicContentSize];
    
    if (statusModel.retweetedStatus) {

        _reScreenName.text = [NSString stringWithFormat:@"@%@", statusModel.retweetedStatus.user.screenName];
        _reText.text = statusModel.retweetedStatus.text;
//        _reImageListView.imageList = statusModel.retweetedStatus.picUrls;
//        [_reImageListView invalidateIntrinsicContentSize];
        
        _retweetView.hidden = NO;
        [_retweetView invalidateIntrinsicContentSize];

    } else {
//        _reImageListView.imageList = @[];
//        [_reImageListView invalidateIntrinsicContentSize];
        
        _retweetView.hidden = YES;
         [_retweetView invalidateIntrinsicContentSize];
    }
    
    [self setButton:_repostsButton withTitle:@"转发" forCounts:statusModel.repostsCount];
    [self setButton:_commentsButton withTitle:@"评论" forCounts:statusModel.commentsCount];
    [self setButton:_attitudesButton withTitle:@"赞" forCounts:statusModel.attitudesCount];
}

@end
