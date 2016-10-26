//
//  YSQKitsModel.h
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQKitsModel : NSObject
@property (nonatomic, copy) NSArray *guides;
@property (nonatomic, copy) NSString *name;

@end

@interface YSQGuidesModel : NSObject

@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, copy) NSString *category_title;
@property (nonatomic, copy) NSString *country_id;
@property (nonatomic, copy) NSString *country_name_cn;
@property (nonatomic, copy) NSString *country_name_en;
@property (nonatomic, copy) NSString *country_name_py;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *cover_updatetime;
@property (nonatomic, strong) NSNumber *download;
@property (nonatomic, copy) NSString *file;
@property (nonatomic, copy) NSString *guide_cnname;
@property (nonatomic, copy) NSString *guide_enname;
@property (nonatomic, copy) NSString *guide_id;
@property (nonatomic, copy) NSString *guide_pinyin;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *update_log;
@property (nonatomic, copy) NSString *update_time;

@end