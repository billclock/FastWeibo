//
//  AppDelegate.m
//  FastWeibo
//
//  Created by Bill Clock on 15/1/6.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "AppDelegate.h"
#import "OAuthViewController.h"
#import "WeiboAccountManager.h"
#import "MainViewController.h"
#import <Mantle/Mantle.h>
#import "CoreData+MagicalRecord.h"
#import "CocoaLumberjack/DDTTYLogger.h"
#import "CocoaLumberjack/DDASLLogger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [MagicalRecord setupAutoMigratingCoreDataStack];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([[WeiboAccountManager sharedManager] isNeedToRefreshToken]) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[OAuthViewController alloc] init]];
        self.window.rootViewController = nav;
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MainViewController *mainViewController = [storyboard instantiateInitialViewController];
        self.window.rootViewController = mainViewController;
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

    [MagicalRecord cleanUp];

}

@end
