//
//  MessageViewController.m
//  FastWeibo
//
//  Created by Bill Clock on 15/1/7.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "MessageViewController.h"
#import "RetweetView.h"

@interface MessageViewController ()
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet RetweetView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
}

- (void)viewDidLayoutSubviews
{
     _textLabel.preferredMaxLayoutWidth = CGRectGetWidth(_textLabel.frame);
    _msgLabel.preferredMaxLayoutWidth = CGRectGetWidth(_msgLabel.frame);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    static int flag = 0;
    flag++;
    
    if (flag % 2 == 0) {
        _textLabel.text = @"WWDC还将举办100多场由1,000多名工程师主讲的技术活动。WDC还将举办100多场由";
        _msgLabel.text = @"WWDC还将举办100多场由WDC还将举办100多场由WDC还将举办100多场由WWDC还将举办100多场由1,000多名工程师主讲的技术活动。WDC还将举办100多场由";
    } else {
        _textLabel.text = @"苹果智能手表Apple Watch自从4月10日公开预售，订单就被抢购一空。苹果中国官方向早报记者表示，苹果手表4月24日首批上市时间没有变，前期网上预购的会通过快递送到用户手里，但目前没有在实体店销售的时间。";
        _msgLabel.text = @"目前没有";
    }
    

//    _msgLabel.hidden = YES;
//    _msgLabel.bounds = CGRectZero;
//    [_msgLabel invalidateIntrinsicContentSize];
    _imageView.hidden = YES;
    [_imageView invalidateIntrinsicContentSize];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
