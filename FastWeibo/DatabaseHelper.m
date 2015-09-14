
#import "DatabaseHelper.h"
#import "TranslatorHelper.h"
#import "StatusModel.h"
#import "StatusManagedObject.h"
#import "Constants.h"
#import "NSManagedObjectContext+BackgroundFetch.h"


@interface DatabaseHelper ()

@property (nonatomic, strong) TranslatorHelper *translatorHelper;

- (NSFetchRequest *)backgroundFetchRequestForEntityName:(NSString *)entityName
                                  withSortDescriptorKey:(NSString *)sortDescriptorKey
                                              ascending:(BOOL)ascending
                                           andPredicate:(NSPredicate *)predicate;

@end

@implementation DatabaseHelper
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


#pragma mark - Private Methods

- (NSFetchRequest *)backgroundFetchRequestForEntityName:(NSString *)entityName
                                  withSortDescriptorKey:(NSString *)sortDescriptorKey
                                              ascending:(BOOL)ascending
                                           andPredicate:(NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.includesPropertyValues = NO;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortDescriptorKey
                                                                   ascending:ascending];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    
    [fetchRequest setFetchLimit:kFetchLimit];
    
    return fetchRequest;
}

#pragma mark - StatusesFetcher Protocol

- (void)getStatusesWithCompletion:(ArrayCompletionBlock)completion
{
    [self getStatusesWithSinceId:0 maxId:0 completion:completion];
}

- (void)getStatusesWithSinceId: (int64_t)sinceId completion:(ArrayCompletionBlock)completion
{
    [self getStatusesWithSinceId:sinceId maxId:0 completion:completion];
}

- (void)getStatusesWithMaxId:(int64_t)maxId completion:(ArrayCompletionBlock)completion
{
    [self getStatusesWithSinceId:0 maxId:maxId completion:completion];
}

- (void)getStatusesWithSinceId:(int64_t)sinceId maxId:(int64_t)maxId completion:(ArrayCompletionBlock)completion
{
    NSPredicate *predicate;
    if (sinceId > 0 && maxId > 0) {
        predicate = [NSPredicate
                    predicateWithFormat:@"statusId > %lld AND statusId <= @lld AND isTimeLine == YES", sinceId, maxId];
    } else if (sinceId > 0) {
        predicate = [NSPredicate
                     predicateWithFormat:@"statusId > %lld AND isTimeLine == YES", sinceId];
    } else if (maxId > 0) {
        predicate = [NSPredicate
                     predicateWithFormat:@"statusId <= %lld AND isTimeLine == YES", maxId];
    } else {
        predicate = [NSPredicate
                     predicateWithFormat:@"isTimeLine == YES"];;
    }
    
    NSFetchRequest *fetchRequest = [self backgroundFetchRequestForEntityName:@"StatusManagedObject"
                                                       withSortDescriptorKey:@"statusId"
                                                                   ascending:NO
                                                                andPredicate:predicate];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    [context executeFetchRequest:fetchRequest
                      completion:^(NSArray *array, NSError *error) {
                          if (array) {
                              completion([[self translatorHelper] translateCollectionfromManagedObjects:array
                                                                                          withClassName:@"StatusModel"], nil);
                          }
                          else {
                              completion(nil, error);
                          }
                      }];
}



#pragma mark - StatusesStorage Protocol

- (void)storeStatuses:(NSArray *)Statuses
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [Statuses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSError *error;
        
            StatusModel *status = (StatusModel *)obj;
            status.isTimeLine = YES;
            if (status.retweetedStatus) {
                StatusModel *retweetedStatus= (StatusModel *)status.retweetedStatus;
                retweetedStatus.isTimeLine = NO;
            }
            [MTLManagedObjectAdapter managedObjectFromModel:status
                                       insertingIntoContext:localContext
                                                      error:&error];
        }];
    } completion:^(BOOL success, NSError *error) {
        if (success) {
            DDLogInfo(@"Statuses stored on database without errors");
        }
        else {
            DDLogInfo(@"Statuses failed to stored on database with Error %@", [error localizedDescription]);
        }
    }];
}


@end
