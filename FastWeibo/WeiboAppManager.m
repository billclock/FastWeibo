//
//  WeiboAppManager.m
//  FastWeibo
//
//  Created by Bill Clock on 15/3/1.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import "WeiboAppManager.h"
#import "NetworkingHelper.h"
#import "DatabaseHelper.h"

@interface WeiboAppManager ()
@property (nonatomic, strong) NetworkingHelper *networkingHelper;
@property (nonatomic, strong) DatabaseHelper *databaseHelper;
@end

static dispatch_once_t oncePredicate;

@implementation WeiboAppManager

#pragma mark - Lazy Loading Pattern

- (NetworkingHelper *)networkingHelper
{
    if (_networkingHelper == nil) {
        _networkingHelper = [[NetworkingHelper alloc] init];
    }
    return _networkingHelper;
}

- (DatabaseHelper *)databaseHelper
{
    if (_databaseHelper == nil) {
        _databaseHelper = [[DatabaseHelper alloc] init];
    }
    return _databaseHelper;
}

#pragma mark - Class Methods

+ (WeiboAppManager *)sharedManager
{
    static WeiboAppManager *_sharedManager;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

#pragma mark - CountriesStorage Protocol

- (void)getStatusesWithCompletion:(ArrayCompletionBlock)completion
{
    [self getStatusesWithSinceId:0 maxId:0 completion:completion];
}

- (void)getStatusesWithSinceId:(int64_t)sinceId maxId:(int64_t)maxId completion:(ArrayCompletionBlock)completion
{
    
    [[self databaseHelper] getStatusesWithSinceId:sinceId maxId:maxId completion:^(NSArray *array, NSError *error) {
        if ([array count] > 0) {
            DDLogInfo(@"Statuses retrieved from database");
            completion(array, nil);
        }
        else {
            [[self networkingHelper] getStatusesWithSinceId:sinceId maxId:maxId completion:^(NSArray *array, NSError *error) {
                if (!error) {
                    if (array && [array count] > 0) {
                        [[self databaseHelper] storeStatuses:array];
                        DDLogInfo(@"Statuses retrieved from network");
                        completion(array, nil);
                    } else {
                        DDLogInfo(@"There are no new statuses from network.");
                        completion(nil, nil);
                    }

                }
                else {
                    completion(nil, error);
                }
            }];
        }
    }];
}

- (void)getStatusesWithSinceId:(int64_t)sinceId completion:(ArrayCompletionBlock)completion
{
    [self getStatusesWithSinceId:sinceId maxId:0 completion:completion];
}

- (void)getStatusesWithMaxId:(int64_t)maxId completion:(ArrayCompletionBlock)completion
{
    [self getStatusesWithSinceId:0 maxId:maxId completion:completion];
}




@end
