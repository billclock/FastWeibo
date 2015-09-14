

#import <CoreData/CoreData.h>
#include "Blocks.h"

@interface NSManagedObjectContext (BackgroundFetch)

- (void)executeFetchRequest:(NSFetchRequest *)request
                 completion:(ArrayCompletionBlock)completion;

@end
