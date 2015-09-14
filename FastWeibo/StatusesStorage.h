

#import <Foundation/Foundation.h>

@protocol StatusesStorage <NSObject>

- (void)storeStatuses:(NSArray *)statuses;

@end
