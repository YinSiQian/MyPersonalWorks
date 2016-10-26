//
//  YSQHotAreaModel.h
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQHotAreaModel : NSObject
@property (nonatomic, copy) NSArray *list;
@property (nonatomic, copy) NSArray *place;
@property (nonatomic, copy) NSString *type;

@end


@interface YSQPlaceModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@end