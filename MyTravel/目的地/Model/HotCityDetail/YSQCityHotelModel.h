//
//  YSQCityHotelModel.h
//  MyTravel
//
//  Created by ysq on 16/3/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YSQHotelModel : NSObject

@property (nonatomic, copy) NSDictionary *area;
@property (nonatomic, copy) NSArray *hotel;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *city_photo;
@property (nonatomic, strong) NSNumber *has_area;

@end


@interface YSQCityIntro : NSObject

@property (nonatomic, copy) NSString *big_map;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *prices;


@end

@interface YSQCityHotelPrice : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *price;

@end




@interface YSQCityHotelModel : NSObject

@property (nonatomic, copy) NSString *area_name;
@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *is_recommend;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lon;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *ranking;
@property (nonatomic, copy) NSString *star;

@end
