//
//  YSQAskModel.h
//  MyTravel
//
//  Created by ysq on 16/4/30.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQAskModel : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSNumber *add_time;
@property (nonatomic,strong) NSString *appview_url;
@property (nonatomic,strong) NSNumber *answer_num;
@property (nonatomic,strong) NSNumber *ask_num;


@end
