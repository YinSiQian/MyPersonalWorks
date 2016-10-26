//
//  YSQKitsDetailModel.m
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQKitsDetailModel.h"

@implementation YSQKitsDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"authors":[YSQAuthorModel class],@"related_guides":[YSQRelateModel class]};
}

@end

@implementation YSQAuthorModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

@end

@implementation YSQMobileModel


@end

@implementation YSQRelateModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"mobile":[YSQMobileModel class]};
//}


@end