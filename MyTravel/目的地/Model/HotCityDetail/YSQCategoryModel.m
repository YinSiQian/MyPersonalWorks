//
//  YSQCategoryModel.m
//  MyTravel
//
//  Created by ysq on 16/6/28.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQCategoryModel.h"

@implementation YSQCategoryModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"children":[YSQChildrenModel class]};
}

@end

@implementation YSQChildrenModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

@end