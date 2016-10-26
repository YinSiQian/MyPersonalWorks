//
//  YSQUserDAO.h
//  MyTravel
//
//  Created by ysq on 16/5/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQUserDAO : NSObject


+ (instancetype)shared;

/**
 *  用户ID
 */
@property (nonatomic, strong) NSNumber *ID;
/**
 *  用户名
 */
@property (nonatomic, strong) NSString *username;
/**
 *  用户账号
 */
@property (nonatomic, strong) NSString *account;
/**
 *  用户密码
 */
@property (nonatomic, strong) NSString *password;

@end
