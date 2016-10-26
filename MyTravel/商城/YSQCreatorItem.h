//
//  YSQCreatorItem.h
//  MyTravel
//
//  Created by ysq on 2016/10/5.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQCreatorItem : NSObject
/** 主播名 */
@property (nonatomic, strong) NSString *nick;
/** 主播头像 */
@property (nonatomic, strong) NSString *portrait;

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, strong) NSNumber *level;

@property (nonatomic, strong) NSNumber *gender;

@end
