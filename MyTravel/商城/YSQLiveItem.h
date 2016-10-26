//
//  YSQLiveItem.h
//  MyTravel
//
//  Created by ysq on 2016/10/5.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YSQCreatorItem;
@interface YSQLiveItem : NSObject

/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 关注人 */
@property (nonatomic, assign) NSUInteger online_users;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 主播 */
@property (nonatomic, strong) YSQCreatorItem *creator;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSNumber *version;

@property (nonatomic, strong) NSNumber *slot;

@property (nonatomic, strong) NSNumber *optimal;

@property (nonatomic, strong) NSNumber *group;

@property (nonatomic, strong) NSNumber *link;

@property (nonatomic, strong) NSNumber *multi;



@end
