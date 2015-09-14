

#import <Foundation/Foundation.h>
#import "StatusesFetcher.h"

@interface NetworkingHelper : NSObject <StatusesFetcher>

- (void)getStatusesWithSinceId:(int64_t)sinceId maxId:(int64_t)maxId completion:(ArrayCompletionBlock)completion;

@end
