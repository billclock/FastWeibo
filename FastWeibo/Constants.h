//
//  Constants.h
//  FastWeibo
//
//  Created by Bill Clock on 15/1/10.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#ifndef FastWeibo_Constants_h
#define FastWeibo_Constants_h

// FWOAuthController:OAuth认证

#define kBaseURL            @"https://api.weibo.com/"
#define kOAuthURL           [kBaseURL stringByAppendingString:@"oauth2/authorize"]  // 新浪OAuth认证URL
#define kAppKey             @"xxxxxxxx"                                             // 开发者帐号AppKey
#define kAppSecret          @"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"                     // 开发者帐号AppSecret
#define kRedirect_Url       @"https://api.weibo.com/oauth2/default.html"            // 新浪OAuth认证回调页面
#define kFetchLimit          20


// FWStatusFrame：微博Frame设置
#define kInterval           10                                              // 微博元素基本边距
#define kProfileWH          34                                              // 用户头像尺寸
#define kScreenNameFont    [UIFont systemFontOfSize:15]                    // 用户昵称字号
#define kMBIconWH           12                                              // 会员图标尺寸
#define kTimeFont           [UIFont systemFontOfSize:10]                    // 发表时间字号
#define kSourceFont         kTimeFont                                       // 微博来源字号
#define kTextFount          [UIFont systemFontOfSize:15]                    // 微博正文字号
#define kReScreenNameFont   [UIFont systemFontOfSize:14]                    // 转发微博体昵称字号
#define kReTextFont         kReScreenNameFont                               // 转发微博体正文字号

// FWAvatar：微博头像处理
#define kAvatarSmallW        34                                              // 用户小头像尺寸宽度
#define kAvatarSmallH        kAvatarSmallW                                    // 用户小头像尺寸高度
#define kAvatarDefaultW      50                                              // 用户中头像尺寸宽度
#define kAvatarDefaultH      kAvatarDefaultW                                  // 用户中头像尺寸高度
#define kAvatarBigW          85                                              // 用户大头像尺寸宽度
#define kAvatarBigH          kAvatarBigW                                      // 用户大头像尺寸高度
#define kVerifiedW          18                                              // 用户类型图标尺寸宽度
#define kVerifiedH          kVerifiedW                                      // 用户类型图标尺寸高度

// FWStatusCell：会员昵称颜色设置
#define kColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define kBGColor            kColor(239, 239, 244)                           // 全局背景颜色
#define kMBScreenNameColor  kColor(240, 100, 20)                            // 会员用户昵称颜色
#define kScreenNameColor    kColor(0, 0, 0)                                 // 普通用户昵称颜色
#define kTimeColor          kColor(200, 100, 30)                            // 微博发表时间显示颜色
#define kCellMargins        (kInterval * 0.5)                               // 单元格两边边距
//#define kCellInterval     kInterval                                       // 单元格相互之间间隔

// FWImageListView 配图处理相关
#define kImageCount         9                                               // 微博配图最大配图数
#define kImageInterval      5                                               // 微博配图间隔
#define kStatusImageOneWH   100                                             // 一张配图尺寸
#define kStatusImageMuWH    80                                              // 多總配图尺寸

// FWStatusDock 功能菜单栏
#define kCellDefaultHeight  44                                              // TableViewCell默认高度
#define kStatusDockHeight   35                                              // 功能菜单栏高度

// FWDetaiRetweetDock
#define kDetailReDockH      30                                              // 转发体Dock栏高度
#define kDetailReDockW      200                                             // 转发体Dock栏宽度

// FWStatusDetailDock
#define kDetailDockH        50                                              // 微博详情Dock高度
#define kDetailDockW        320                                             // 微博详情Dock宽度


#endif
