//
//  YSQKitsDetailModel.h
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQKitsDetailModel : NSObject

@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, copy) NSString *category_title;
@property (nonatomic, copy) NSString *country_id;
@property (nonatomic, copy) NSString *country_name_cn;
@property (nonatomic, copy) NSString *country_name_en;
@property (nonatomic, copy) NSString *country_name_py;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *cover_updatetime;
@property (nonatomic, strong) NSNumber *download;
@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSArray *authors;
@property (nonatomic, copy) NSDictionary *mobile;
@property (nonatomic, copy) NSArray *related_guides;

@end

@interface YSQAuthorModel : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *username;

@end

@interface YSQMobileModel : NSObject
@property (nonatomic, copy) NSString *file;
@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSNumber *size;

@end

@interface YSQRelateModel : NSObject

@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, copy) NSString *category_title;
@property (nonatomic, copy) NSString *country_id;
@property (nonatomic, copy) NSString *country_name_cn;
@property (nonatomic, copy) NSString *country_name_en;
@property (nonatomic, copy) NSString *country_name_py;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *cover_updatetime;
@property (nonatomic, strong) NSNumber *download;
@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *pinyin;
@property (nonatomic, copy) NSDictionary *mobile;
@property (nonatomic, copy) NSString *update_time;




@end

