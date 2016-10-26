//
//  MTSubjectModel.m
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQSubjectModel.h"

@implementation YSQSubjectModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        _url = dict[@"url"];
        _photo = dict[@"photo"];
        _title = dict[@"title"];
    }
    return self;
}

+ (instancetype)ModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
