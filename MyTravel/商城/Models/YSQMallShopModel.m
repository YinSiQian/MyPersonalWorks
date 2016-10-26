//
//  YSQMallShopModel.m
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQMallShopModel.h"

@implementation YSQMallShopModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"discount_topic":[YSQShopDiscountModel class],@"hot_area":[YSQHotAreaModel class],@"hot_goods":[YSQMallHotGoodsModel class],@"market_topic":[YSQMallMarketModel class]};
}
@end
