//
//  YSQNewDiscount.m
//  MyTravel
//
//  Created by ysq on 16/1/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQNewDiscount.h"

@implementation YSQNewDiscount

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _photo = dict[@"photo"];
        _title = dict[@"title"];
        _price =dict[@"price"];
        _priceoff = dict[@"priceoff"];
        _ID = dict[@"id"];
        _url = dict[@"url"];
    }
    return self;
}

+ (instancetype)ModelWithDict:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];
}
@end
