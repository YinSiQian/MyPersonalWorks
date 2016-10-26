//
//  YSQNewDiscount.h
//  MyTravel
//
//  Created by ysq on 16/1/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQNewDiscount : NSObject
@property (nonatomic,strong) NSNumber *ID;
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *priceoff;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ModelWithDict:(NSDictionary *)dict;

@end
