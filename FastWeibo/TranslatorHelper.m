
#import "TranslatorHelper.h"
#import "StatusModel.h"
#import <Mantle/Mantle.h>

@implementation TranslatorHelper

- (id)translateModelFromJSON:(NSDictionary *)JSON
                withclassName:(NSString *)className
{
    NSParameterAssert(className != nil);
    NSError *error = nil;
    id model = [MTLJSONAdapter modelOfClass:NSClassFromString(className)
                         fromJSONDictionary:JSON
                                      error:&error];
    if (!error) {
        return model;
    } else {
        return nil;
    }
}

- (id)translateCollectionFromJSON:(NSDictionary *)JSON
                    withClassName:(NSString *)className
{
    NSParameterAssert(className != nil);
    if ([JSON isKindOfClass:[NSArray class]]) {
        NSValueTransformer *valueTransformer = [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:NSClassFromString(className)];
        NSArray *collection = [valueTransformer transformedValue:JSON];
        return collection;
    }
    return nil;
}

- (id)translateModelfromManagedObject:(NSManagedObject *)managedObject
                        withClassName:(NSString *)className
{
    NSParameterAssert(className != nil);
    NSError *error = nil;
    id model = [MTLManagedObjectAdapter modelOfClass:NSClassFromString(className)
                                   fromManagedObject:managedObject
                                               error:&error];
    if (!error) {
        return model;
    } else {
        return nil;
    }
}

- (id)translateCollectionfromManagedObjects:(NSArray *)managedObjects
                              withClassName:(NSString *)className
{
    NSParameterAssert(className != nil);
    if ([managedObjects isKindOfClass:[NSArray class]]) {
        NSMutableArray *collection = [NSMutableArray array];
        for (NSManagedObject *managedObject in managedObjects) {
            id model = [self translateModelfromManagedObject:managedObject
                                               withClassName:className];

            [collection addObject:model];
        }
        return collection;
    }
    return nil;
}

@end
