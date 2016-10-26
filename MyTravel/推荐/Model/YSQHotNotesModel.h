//
//  MTHotNotesModel.h
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQHotNotesModel : NSObject
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *replys;
@property (nonatomic, copy) NSNumber *views;
@property (nonatomic, retain) NSNumber *ID;
@property (nonatomic, copy) NSString *view_url;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ModelWithDict:(NSDictionary *)dict;

@end
