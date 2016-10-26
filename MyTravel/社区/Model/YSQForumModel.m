//
//  YSQForumModel.m
//  MyTravel
//
//  Created by ysq on 16/3/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQForumModel.h"
#import "YSQGroupModel.h"

@implementation YSQForumModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"group":[YSQGroupModel class]};
}

@end
