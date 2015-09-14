//
//  UserManagedObject.h
//  FastWeibo
//
//  Created by Bill Clock on 15/3/5.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserManagedObject : NSManagedObject

@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * profileImageUrl;
@property (nonatomic, retain) NSString * screenName;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSNumber * verified;

@end
