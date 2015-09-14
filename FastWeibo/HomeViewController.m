//
//  HomeViewController.m
//  FastWeibo
//
//  Created by Bill Clock on 15/1/7.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboHttpManager.h"
#import "WeiboAccount.h"
#import "WeiboAccountManager.h"
#import "Constants.h"
#import "WeiboMessageManager.h"
#import "WeiboAppManager.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "FWHomeStatusCell.h"
#import <MJRefresh/MJRefresh.h>
#import "FWHomeStatusCellFrame.h"
#import "ImageBrowserView.h"
#import "FWImageView.h"
#import "FWImageListView.h"
#import "ImageZoomScrollView.h"


@interface HomeViewController ()

@property (nonatomic, strong) NSMutableArray *statusFrameArray;
@property (nonatomic, strong) ImageBrowserView *imageBrowserView;

@end

@implementation HomeViewController

#pragma mark - View Controller Life Cycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _statusFrameArray = [NSMutableArray array];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"首页";
    
    [self setupImageBrowserView];
    [self setupMJRefreh];
    
    [self loadStatuses];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThumbPicTapped:) name:@"msg_img_tapped" object:nil];


}

- (void)handleThumbPicTapped:(NSNotification *)notification
{
    FWImageView *imgView = notification.object;
    FWImageListView *imgListView = (FWImageListView *)[imgView superview];
    NSUInteger currentIndex = (imgView.tag - 10);
    
    [self.imageBrowserView addSubImageViewByImgListView:imgListView currentIndex:currentIndex];
    [self.imageBrowserView performSelector:@selector(playShowAnimation) withObject:nil afterDelay:0.1];

}

- (void)setupImageBrowserView
{
    self.imageBrowserView = [[ImageBrowserView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.imageBrowserView.hidden = YES;

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.imageBrowserView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UITableViewCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath
//{
//    StatusCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[StatusCell indentifier] forIndexPath:indexPath];
//
//    
//    [self configureBasicCell:cell atIndexPath:indexPath];
//    
//    return cell;
//}

//- (void)configureBasicCell:(StatusCell *)cell atIndexPath:(NSIndexPath *)indexPath
//{
//    StatusModel *status = [_statuses objectAtIndex:indexPath.row];
//    [cell setStatusModel:status];
//}
//
//- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
//    static StatusCell *sizingCell = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:[StatusCell indentifier]];
//    });
//    
//    [self configureBasicCell:sizingCell atIndexPath:indexPath];
//    
//    return [self calculateHeightForConfiguredSizingCell:sizingCell];
//}
//
//- (CGFloat)calculateHeightForConfiguredSizingCell:(StatusCell *)sizingCell
//{
//    
//    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(sizingCell.bounds));
//    
//    [sizingCell setNeedsLayout];
//    [sizingCell layoutIfNeeded];
//    
//    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    
//    return size.height + 1.0f; // Add 1.0f for the cell separator height
//}

#pragma mark - Table view

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [_statusFrameArray[indexPath.row] cellHeight];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_statusFrameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FWHomeStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:[FWHomeStatusCell ID]];
    
    if (cell == nil){
        cell = [[FWHomeStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[FWHomeStatusCell ID]];
    }
    
    // 单元格内容由框架模型提供
    cell.cellFrame = _statusFrameArray[indexPath.row];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - MJRefresh
- (void)setupMJRefreh
{
    // 1、下拉刷新控件
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(onHeaderRefreshing)];
    
    // 2、上拉加载更多控件
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(onFooterRefreshing)];

}

#pragma mark - Refresh Methods

- (void)onHeaderRefreshing
{
    // 1、取出首个模型数据
    FWHomeStatusCellFrame *tempStatus = [_statusFrameArray firstObject];
    int64_t sinceId  = tempStatus.dataModel.statusId;
    
    [[WeiboAppManager sharedManager] getStatusesWithSinceId: sinceId completion:^(NSArray *array, NSError *error) {
        if (!error) {
            if (array) {
                NSArray *newFrame = [self statusFrameTranslateFromStatusArray:array];
                [_statusFrameArray insertObjects:newFrame atIndexes:
                    [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrame.count)]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                [self showNewStatusMessage:array.count];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.header endRefreshing];
        });
    }];
}

- (void)onFooterRefreshing
{
    FWHomeStatusCellFrame *tempStatus = [_statusFrameArray lastObject];
    int64_t maxId = tempStatus.dataModel.statusId;
    
    [[WeiboAppManager sharedManager] getStatusesWithMaxId:maxId-1 completion:^(NSArray *array, NSError *error) {
        if (!error) {
            if (array) {
                NSArray *newFrame = [self statusFrameTranslateFromStatusArray:array];
                [_statusFrameArray addObjectsFromArray:newFrame];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.footer endRefreshing];
        });
    }];
}

#pragma mark - New Status Message
- (void)showNewStatusMessage:(NSUInteger)count
{
    // 1、创建按钮设置基本属性
    UIButton *msgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    msgButton.enabled = NO;
    msgButton.adjustsImageWhenDisabled = NO;
    NSString *title;
    
    if (count) {    // 如果count不为空则显示"n条新微博"
        title = [NSString stringWithFormat:@"恭喜获得 %d 条新微博", (int)count];
    } else {        // 如果count值为0则显示"无最新微博"
        title = @"很遗憾 一无所获";
    }
    
    msgButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [msgButton setTitle:title forState:UIControlStateNormal];
    
    UIImage *image = [UIImage imageNamed:@"timeline_new_status_background.png"];
    image = [image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [msgButton setBackgroundImage:image forState:UIControlStateNormal];
    
    [self.navigationController.view insertSubview:msgButton belowSubview:self.navigationController.navigationBar];
    
    // 2、设置显示动画
    CGFloat height = 44;
    // 自适应ios7与ios6导航条控件原点
    CGFloat y = self.navigationController.navigationBar.frame.origin.y;
    msgButton.frame = CGRectMake(0, y, self.tableView.frame.size.width, height);
    msgButton.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{   // 半秒时间淡出效果
        
        msgButton.alpha = 0.9;
        msgButton.transform = CGAffineTransformTranslate(msgButton.transform, 0, height);
        
    } completion:^(BOOL finished) {                 // 停留1.5秒后弹回
        [UIView animateWithDuration:1.0 delay:1.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            msgButton.transform = CGAffineTransformTranslate(msgButton.transform, 0, -height);
            msgButton.alpha = 0;
            
        } completion:^(BOOL finished) {             // 动画结束移除控件
            [msgButton removeFromSuperview];
        }];
    }];
    
    
}


#pragma mark - Private Methods

- (void)loadStatuses
{
    [[WeiboAppManager sharedManager] getStatusesWithCompletion:^(NSArray *array, NSError *error) {
        if (!error) {
            if (array) {
                
                NSArray *newFrame = [self statusFrameTranslateFromStatusArray:array];
                [_statusFrameArray removeAllObjects];
                [_statusFrameArray addObjectsFromArray:newFrame];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }
    }];
}

// 将请求到的微博数据模型转成微博框架模型
- (NSArray *)statusFrameTranslateFromStatusArray:(NSArray *)statusArray
{
    NSMutableArray *statusFrameArray = [NSMutableArray array];
    for (StatusModel *status in statusArray) {
        FWHomeStatusCellFrame *statusCellFrame = [[FWHomeStatusCellFrame alloc] init];
        statusCellFrame.dataModel = status;
        [statusFrameArray addObject:statusCellFrame];
    }
    return statusFrameArray;
}


@end
