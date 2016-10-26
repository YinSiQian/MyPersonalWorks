//
//  MTHotNotesModel.m
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotNotesModel.h"

@implementation YSQHotNotesModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        _photo = dict[@"photo"];
        _title = dict[@"title"];
        _username =dict[@"username"];
        _replys = dict[@"replys"];
        _views = dict[@"views"];
        _ID = dict[@"id"];
        _view_url = dict[@"view_url"];
    }
    return self;
}

+ (instancetype)ModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
