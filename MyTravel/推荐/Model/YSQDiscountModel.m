//
//  MTDiscountModel.m
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQDiscountModel.h"

@implementation YSQDiscountModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        _photo = dict[@"photo"];
        _ID = dict[@"id"];
        _price = dict[@"price"];
        _priceoff = dict[@"priceoff"];
        _end_date = dict[@"end_date"];
        _title = dict[@"title"];
    }
    return self;
}

+ (instancetype)ModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
