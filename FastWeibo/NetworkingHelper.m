

#import <Mantle/Mantle.h>
#import <AFNetworking/AFNetworking.h>
#import "WeiboAccountManager.h"
#import "WeiboHttpManager.h"
#import "NetworkingHelper.h"
#import "StatusModel.h"
#import "Constants.h"
#import "TranslatorHelper.h"
#import "Blocks.h"

@interface NetworkingHelper ()

@property (nonatomic, strong) TranslatorHelper *translatorHelper;

@end

@implementation NetworkingHelper
{
}

#pragma mark - Lazy Loading Pattern

- (TranslatorHelper *)translatorHelper
{
    if (_translatorHelper == nil) {
        _translatorHelper = [[TranslatorHelper alloc] init];
    }
    return _translatorHelper;
}


#pragma mark - StatusesFetcher Protocol

- (void)getStatusesWithCompletion:(ArrayCompletionBlock)completion
{
    [self getStatusesWithSinceId:0 maxId:0 completion:completion];
}

- (void)getStatusesWithSinceId:(int64_t)sinceId completion:(ArrayCompletionBlock)completion
{
    
    [self getStatusesWithSinceId:sinceId maxId:0 completion:completion];
}

- (void)getStatusesWithMaxId:(int64_t)maxId completion:(ArrayCompletionBlock)completion
{
    [self getStatusesWithSinceId:0 maxId:maxId completion:completion];
}

- (void)getStatusesWithSinceId:(int64_t)sinceId maxId:(int64_t)maxId completion:(ArrayCompletionBlock)completion
{
    
    WeiboAccount *account = [[WeiboAccountManager sharedManager] account];
    NSString *authToken = account.accessToken;
    
    NSMutableDictionary  *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:authToken, @"access_token", nil];
    NSString *tempString = nil;
    if (sinceId > 0) {
        tempString = [NSString stringWithFormat:@"%lld", sinceId];
        [params setObject:tempString forKey:@"since_id"];
    }
    
    if (maxId > 0) {
        tempString = [NSString stringWithFormat:@"%lld", maxId];
        [params setObject:tempString forKey:@"max_id"];
    }
 
    tempString = [NSString stringWithFormat:@"%d", kFetchLimit];
    [params setObject:tempString forKey:@"count"];

    
    [[WeiboHttpManager sharedManager] GET:@"2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (!completion) {
            return;
        }
        
        NSArray *collection = [[self translatorHelper] translateCollectionFromJSON:[responseObject objectForKey:@"statuses"] withClassName:@"StatusModel"];
        
        
        
        completion(collection, nil);
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
        
    }];

}


@end
