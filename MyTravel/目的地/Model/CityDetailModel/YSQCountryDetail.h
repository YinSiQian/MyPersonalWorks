//
//  YSQCityDetail.h
//  MyTravel
//
//  Created by ysq on 16/1/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YSQHotCity;
@class YSQNewDiscount;
@interface YSQCountryDetail : NSObject
@property (nonatomic, copy) NSString *entryCont;
@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, strong) NSArray *local_discount;
@property (nonatomic, strong) NSArray *hot_city;
@property (nonatomic, strong) NSArray *New_discount;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, copy) NSString *overview_url;
@property (nonatomic, strong) YSQNewDiscount *localModel;
@property (nonatomic, strong) YSQHotCity *hotModel;
@property (nonatomic, strong) YSQNewDiscount *NewModel;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ModelWithDict:(NSDictionary *)dict;
@end
