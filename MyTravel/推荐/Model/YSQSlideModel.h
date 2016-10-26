//
//  MTSlideModel.h
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQSlideModel : NSObject
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ModelWithDict:(NSDictionary *)dict;

@end
