//
//  YSQHotBBSModel.h
//  MyTravel
//
//  Created by ysq on 16/6/17.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQHotBBSModel : NSObject
@property (nonatomic, copy) NSString *appview_url;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *forum;
@property (nonatomic, copy) NSString *forum_id;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *is_best;
@property (nonatomic, strong) NSNumber *is_hot;
@property (nonatomic, strong) NSNumber *reply_num;
@property (nonatomic, copy) NSString *reply_time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, strong) NSArray *bigpic_arr;
@end
