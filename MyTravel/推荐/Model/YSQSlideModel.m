//
//  MTSlideModel.m
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQSlideModel.h"

@implementation YSQSlideModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        _photo = dict[@"photo"];
        _url = dict[@"url"];
    }
    return self;
}

+ (instancetype)ModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
