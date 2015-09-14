
#import <Foundation/Foundation.h>
#import "Blocks.h"

@protocol StatusesFetcher <NSObject>

- (void)getStatusesWithCompletion:(ArrayCompletionBlock)completion;
- (void)getStatusesWithSinceId:(int64_t)sinceId completion:(ArrayCompletionBlock)completion;
- (void)getStatusesWithMaxId:(int64_t)maxId completion:(ArrayCompletionBlock)completion;
- (void)getStatusesWithSinceId:(int64_t)sinceId maxId:(int64_t)maxId completion:(ArrayCompletionBlock)completion;

@end
