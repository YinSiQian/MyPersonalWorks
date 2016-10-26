//
//  MTDiscountModel.h
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQDiscountModel : NSObject
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *priceoff;
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSString *end_date;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ModelWithDict:(NSDictionary *)dict;
@end
