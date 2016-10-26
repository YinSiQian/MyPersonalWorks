//
//  YSQSearchResultModel.h
//  MyTravel
//
//  Created by ysq on 16/8/28.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQSearchResultModel : NSObject
@property (nonatomic, copy) NSString *view_url;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, strong) NSNumber *likes;
@property (nonatomic, strong) NSNumber *views;
@property (nonatomic, strong) NSNumber *replys;
@property (nonatomic, strong) NSNumber *lastpost;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *user_id;
@end
