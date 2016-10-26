//
//  YSQHotCity.h
//  MyTravel
//
//  Created by ysq on 16/1/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQHotCity : NSObject

@property (nonatomic,copy) NSString *cnname;
@property (nonatomic,copy) NSString *enname;
@property (nonatomic,strong) NSNumber *hot_id;
@property (nonatomic,copy) NSString *photo;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ModelWithDict:(NSDictionary *)dict;

@end
