//
//  StatusManagedObject.h
//  FastWeibo
//
//  Created by Bill Clock on 15/3/5.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PicUrlManagedObject, StatusManagedObject, UserManagedObject;

@interface StatusManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * attitudesCount;
@property (nonatomic, retain) NSNumber * commentsCount;
@property (nonatomic, retain) NSString * createdAt;
@property (nonatomic, retain) NSNumber * favorited;
@property (nonatomic, retain) NSNumber * isTimeLine;
@property (nonatomic, retain) NSNumber * repostsCount;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSNumber * statusId;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * truncated;
@property (nonatomic, retain) NSSet *picUrls;
@property (nonatomic, retain) StatusManagedObject *retweetedStatus;
@property (nonatomic, retain) UserManagedObject *user;
@end

@interface StatusManagedObject (CoreDataGeneratedAccessors)

- (void)addPicUrlsObject:(PicUrlManagedObject *)value;
- (void)removePicUrlsObject:(PicUrlManagedObject *)value;
- (void)addPicUrls:(NSSet *)values;
- (void)removePicUrls:(NSSet *)values;

@end
