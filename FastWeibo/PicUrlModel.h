//
//  PicUrlModel.h
//  FastWeibo
//
//  Created by Bill Clock on 15/2/9.
//  Copyright (c) 2015年 Bill Clock. All rights reserved.
//

#import  <Mantle/Mantle.h>

@interface PicUrlModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, retain) NSString *thumbnailPic;

@end
