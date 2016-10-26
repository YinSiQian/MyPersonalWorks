//
//  YSQHotCity.m
//  MyTravel
//
//  Created by ysq on 16/1/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotCity.h"

@implementation YSQHotCity

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _enname = dict[@"enname"];
        _cnname = dict[@"cnname"];
        _photo = dict[@"photo"];
        _hot_id = dict[@"id"];
    }
    return self;
}

+ (instancetype)ModelWithDict:(NSDictionary *)dict {
    return  [[self alloc]initWithDict:dict];
}
@end
