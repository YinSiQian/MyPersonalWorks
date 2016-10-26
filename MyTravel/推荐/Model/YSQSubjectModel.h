//
//  MTSubjectModel.h
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQSubjectModel : NSObject
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *title;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ModelWithDict:(NSDictionary *)dict;
@end
