//
//  YSQCityDetail.m
//  MyTravel
//
//  Created by ysq on 16/1/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQCountryDetail.h"
#import "YSQHotCity.h"
#import "YSQNewDiscount.h"

@implementation YSQCountryDetail

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        NSMutableArray * hot = [NSMutableArray array];
        NSMutableArray * NEW =[NSMutableArray array];
        NSMutableArray * local =[NSMutableArray array];
        _cnname = dict[@"cnname"];
        _enname = dict[@"enname"];
        _entryCont = dict[@"entryCont"];
        _overview_url = dict[@"overview_url"];
        _photos = dict[@"photos"];
        _hot_city = dict[@"hot_city"];
        _New_discount = dict[@"new_discount"];
        _local_discount = dict[@"local_discount"];
        for (NSDictionary * dic in _local_discount) {
            _localModel = [YSQNewDiscount ModelWithDict:dic];
            [local addObject:_localModel];
        }
        for (NSDictionary * dic in _hot_city) {
            _hotModel = [YSQHotCity ModelWithDict:dic];
            [hot addObject:_hotModel];
        }
        for (NSDictionary * dic in _New_discount) {
            _NewModel = [YSQNewDiscount ModelWithDict:dic];
            [NEW addObject:_NewModel];
        }
        _hot_city = [hot copy];
        _New_discount = [NEW copy];
        _local_discount = [local copy];
    }
    return self;
}

+ (instancetype)ModelWithDict:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];
}

@end
