//
//  YSQMallShopModel.h
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSQHotAreaModel.h"
#import "YSQMallMarketModel.h"
#import "YSQMallHotGoodsModel.h"
#import "YSQShopDiscountModel.h"
#import "YSQMallListModel.h"

@interface YSQMallShopModel : NSObject

@property (nonatomic, copy) NSArray *discount_topic;
@property (nonatomic, copy) NSArray *hot_area;
@property (nonatomic, copy) NSArray *hot_goods;
@property (nonatomic, copy) NSArray *market_topic;

@end

