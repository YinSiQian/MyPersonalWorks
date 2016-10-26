//
//  YSQChooseTypeModel.h
//  MyTravel
//
//  Created by ysq on 16/4/15.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQChooseTypeModel : NSObject
@property (nonatomic, copy) NSArray *departure;
@property (nonatomic, copy) NSArray *poi;
@property (nonatomic, copy) NSArray *times_drange;
@property (nonatomic, copy) NSArray *type;

@end

@interface YSQDepartureModel : NSObject
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *city_des;

@end

@interface YSQPoiModel : NSObject
@property (nonatomic, strong) NSNumber *continent_id;
@property (nonatomic, copy) NSString *continent_name;
@property (nonatomic, copy) NSArray *country;

@end

@interface YSQCountryModel : NSObject
@property (nonatomic, strong) NSNumber *country_id;
@property (nonatomic, copy) NSString *country_name;

@end

@interface YSQTimesModel : NSObject
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *times;

@end

@interface YSQTypeModel : NSObject
@property (nonatomic, copy) NSString *catename;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *name;



@end

