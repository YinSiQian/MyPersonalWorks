//
//  YSQPlayModel.m
//  MyTravel
//
//  Created by ysq on 16/3/2.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQPlayModel.h"
#import "YSQPlayDiscountModel.h"

@implementation YSQPlayModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"discounts":[YSQPlayDiscountModel class]};
}

@end
