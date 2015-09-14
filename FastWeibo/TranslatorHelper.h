

#import <Foundation/Foundation.h>

@interface TranslatorHelper : NSObject

- (id)translateModelFromJSON:(NSDictionary *)JSON
                withclassName:(NSString *)className;
- (id)translateCollectionFromJSON:(NSDictionary *)JSON
                    withClassName:(NSString *)className;
- (id)translateModelfromManagedObject:(NSManagedObject *)managedObject
                        withClassName:(NSString *)className;
- (id)translateCollectionfromManagedObjects:(NSArray *)managedObjects
                              withClassName:(NSString *)className;

@end
