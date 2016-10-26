//
//  MTRecommendModel.m
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQRecommendModel.h"
#import "YSQSlideModel.h"
#import "YSQSubjectModel.h"
#import "YSQDiscountModel.h"

@implementation YSQRecommendModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        
        NSMutableArray * dis  = [NSMutableArray array];
        NSMutableArray * scr = [NSMutableArray array];
        NSMutableArray *sub = [NSMutableArray array];
        _discount_subject = dict[@"discount_subject"];
        _discount = dict[@"discount"];
        _slide = dict[@"slide"];
        _subject = dict[@"subject"];
        for (NSDictionary *dic in self.discount) {
            _discountModel = [YSQDiscountModel ModelWithDict:dic];
            [dis  addObject:_discountModel];
        }
        _discount = [dis copy];
        for (NSDictionary * dic in self.slide) {
            _slideModel = [YSQSlideModel ModelWithDict:dic];
            [scr addObject:_slideModel];
        }
        _slide = [scr copy];
        for (NSDictionary * dic in self.subject) {
            _subjectModel = [YSQSubjectModel ModelWithDict:dic];
            [sub addObject:_subjectModel];
        }
        _subject = [sub copy];
    }
    return self;
}

+ (instancetype)ModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
