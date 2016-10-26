//
//  MTRecommendModel.h
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSQDiscountModel;
@class YSQSlideModel;
@class YSQSubjectModel;
@interface YSQRecommendModel : NSObject
@property (nonatomic,strong) NSArray *discount;
@property (nonatomic,strong) NSArray *slide;
@property (nonatomic,strong) NSArray *subject;
@property (nonatomic,strong) NSArray *discount_subject;
@property (nonatomic,strong) YSQSlideModel *slideModel;
@property (nonatomic,strong) YSQSubjectModel *subjectModel;
@property (nonatomic,strong) YSQDiscountModel *discountModel;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ModelWithDict:(NSDictionary *)dict;
@end
