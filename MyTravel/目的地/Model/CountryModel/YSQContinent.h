//
//  YSQCountry.h
//  MyTravel
//
//  Created by ysq on 16/2/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSQCountry;
@interface YSQContinent : NSObject
@property (nonatomic,copy) NSString *cnname;
@property (nonatomic,copy) NSString *enname;
@property (nonatomic,strong) NSNumber *ID;
@property (nonatomic,strong) NSArray *country;
@property (nonatomic,strong) NSArray *hot_country;
@property (nonatomic, strong) YSQCountry *countryModel;
@property (nonatomic, strong) YSQCountry *hotCountryModel;


@end
