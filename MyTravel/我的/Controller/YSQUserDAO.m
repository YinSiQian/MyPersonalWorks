//
//  YSQUserDAO.m
//  MyTravel
//
//  Created by ysq on 16/5/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQUserDAO.h"

@implementation YSQUserDAO

+ (instancetype)shared {
    static YSQUserDAO *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YSQUserDAO alloc]init];
    });
    return instance;
}

@end
