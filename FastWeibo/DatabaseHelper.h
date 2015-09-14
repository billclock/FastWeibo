

#import <Foundation/Foundation.h>
#import "StatusesFetcher.h"
#import "StatusesStorage.h"

@class StatusManagedObject;

@interface DatabaseHelper : NSObject <StatusesFetcher, StatusesStorage>

@end
