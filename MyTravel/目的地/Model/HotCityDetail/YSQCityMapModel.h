//
//  YSQCityMapModel.h
//  MyTravel
//
//  Created by ysq on 16/6/27.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQCityMapModel : NSObject
@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *tags_name;
@property (nonatomic, strong) NSNumber *planto;
@property (nonatomic, strong) NSNumber *mapstatus;
@property (nonatomic, assign) BOOL is_recommend;
@property (nonatomic, assign) NSInteger viewCount;


@end
