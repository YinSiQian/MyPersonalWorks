//
//  YSQAddressModel.h
//  MyTravel
//
//  Created by ysq on 16/5/24.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQAddressModel : NSObject

@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *pinyin;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *is_hot;


@end
