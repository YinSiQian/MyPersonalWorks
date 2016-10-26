//
//  YSQHotAreaModel.m
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotAreaModel.h"
#import "YSQMallListModel.h"

@implementation YSQHotAreaModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[YSQMallListModel class],@"place":[YSQPlaceModel class]};
}
@end

@implementation YSQPlaceModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

@end