//
//  YSQShopDiscountModel.m
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQShopDiscountModel.h"
#import "YSQMallListModel.h"

@implementation YSQShopDiscountModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[YSQMallListModel class]};
}
@end
