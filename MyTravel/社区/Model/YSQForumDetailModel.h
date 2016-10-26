//
//  YSQForumDetailModel.h
//  MyTravel
//
//  Created by ysq on 16/4/30.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQForumDetailModel : NSObject

@property (nonatomic, copy) NSString *discuss_group_id;
@property (nonatomic, strong) NSArray *entry;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *parent_name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *total;

@end

@interface YSQEntryModel : NSObject
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, strong) NSNumber *digest_level;
@property (nonatomic, strong) NSNumber *forum_type;
@property (nonatomic, strong) NSNumber *lastpost;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *replys;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *publish_time;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *appview_url;
@property (nonatomic, strong) NSNumber *is_top;
@property (nonatomic, copy) NSString *view_url;
@end
