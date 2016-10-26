//
//  YSQGroupModel.m
//  MyTravel
//
//  Created by ysq on 16/3/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQGroupModel.h"

@implementation YSQGroupModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id",@"Description":@"description"};
}

@end
