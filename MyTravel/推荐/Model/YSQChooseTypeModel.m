//
//  YSQChooseTypeModel.m
//  MyTravel
//
//  Created by ysq on 16/4/15.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQChooseTypeModel.h"

@implementation YSQChooseTypeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"departure":[YSQDepartureModel class],@"poi":[YSQPoiModel class],@"times_drange":[YSQTimesModel class],@"type":[YSQTypeModel class]};
}

@end

@implementation YSQDepartureModel


@end

@implementation YSQCountryModel


@end

@implementation YSQPoiModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"country":[YSQCountryModel class]};
}

@end

@implementation YSQTimesModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Description":@"description"};
}

@end

@implementation YSQTypeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}


@end