//
//  YSQCityHotelModel.m
//  MyTravel
//
//  Created by ysq on 16/3/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQCityHotelModel.h"


@implementation YSQHotelModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"hotel":[YSQCityHotelModel class],@"area":[YSQCityIntro class]};
}


@end

@implementation YSQCityIntro

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"prices":[YSQCityHotelPrice class]};
}

@end

@implementation YSQCityHotelPrice


@end



@implementation YSQCityHotelModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
@end



