//
//  OAuthViewController.m
//  FastWeibo
//
//  Created by Bill Clock on 15/1/10.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//
#import "Constants.h"
#import "OAuthViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "WeiboHttpManager.h"
#import "WeiboAccount.h"
#import "WeiboAccountManager.h"
#import "MainViewController.h"

@interface OAuthViewController () <UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation OAuthViewController

- (void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = _webView;
    _webView.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *requestURLString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&display=mobile", kOAuthURL, kAppKey, kRedirect_Url];
    
    NSURL *url = [NSURL URLWithString:requestURLString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAccessToken:(NSString *)requestToken
{
    
    NSDictionary *params = @{
                             @"client_id" : kAppKey,
                             @"client_secret" : kAppSecret,
                             @"grant_type" : @"authorization_code",
                             @"code" : requestToken,
                             @"redirect_uri" : kRedirect_Url
                            };
    
    [[WeiboHttpManager sharedManager] POST:@"oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        // 1 将JSON转换成数据模型并归档
        WeiboAccount *account = [WeiboAccount accountWithDict:responseObject];
        [[WeiboAccountManager sharedManager] saveAccount:account];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MainViewController *mainViewController = [storyboard instantiateInitialViewController];
        self.view.window.rootViewController = mainViewController;
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

#pragma mark - WebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"code="];
    if (range.length) {
        NSInteger index = range.location + range.length;
        NSString *requestToken = [url substringFromIndex:index];
        
        [self getAccessToken: requestToken];
        
        return NO;
    }
    
    return true;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 引入第三方框架"MBProgressHUD"添加页面加载提示
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:webView animated:YES];
    hud.labelText = @"卖力加载中...";                    // 设置文字
    hud.labelFont = [UIFont systemFontOfSize:14];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 清除页面加载提示
    [MBProgressHUD hideAllHUDsForView:webView animated:YES];
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
