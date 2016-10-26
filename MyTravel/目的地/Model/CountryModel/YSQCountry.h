//
//  YSQCountry.h
//  MyTravel
//
//  Created by ysq on 16/2/7.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQCountry : NSObject

@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *flag;
@property (nonatomic, strong) NSNumber *ID;

@end
