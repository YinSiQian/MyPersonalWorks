//
//  NSString+SQAdd.h
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SQAdd)

/**
 *  日期格式化
 *
 *  @param time 时间秒数
 *
 *  @return 格式化后的日期字符串
 */
+ (NSString *)formatterTime:(NSNumber *)time;

/**
 *  时间戳
 *
 *  @param time 时间秒数
 *
 *  @return 时间戳如:刚刚,几分钟前,几小时前等
 */
+ (NSString *)countTimeFromNow:(NSString *)time;

/**
 *  计算字符串size
 *
 *  @param text    需要计算的字符串
 *  @param font    字符串的字号
 *  @param maxSize 字符串最大的size
 *
 *  @return 返回计算好的字符串的size
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

@end
