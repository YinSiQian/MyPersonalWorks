//
//  NSString+SQAdd.m
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "NSString+SQAdd.h"

@implementation NSString (SQAdd)

+ (NSString *)formatterTime:(NSNumber *)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.doubleValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *formmatterTime = [dateFormatter stringFromDate:date];
    return formmatterTime;
}

+ (NSString *)countTimeFromNow:(NSString *)time {
    NSDate *datenow = [NSDate date];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.doubleValue];
    long dd = (long)[datenow timeIntervalSince1970] - [date timeIntervalSince1970];
    NSString *timeString=@"";
    if (dd/3600<1) {
        if (dd / 60 <= 2) {
            timeString = @"刚刚";
        } else {
            timeString = [NSString stringWithFormat:@"%ld", dd/60];
            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        }
    }
    if (dd/3600.0>1&&dd/86400<1) {
        timeString = [NSString stringWithFormat:@"%ld", dd/3600];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (dd/86400.0>1 && dd / 86400.0 <15) {
        timeString = [NSString stringWithFormat:@"%ld", dd/86400];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    if (dd / 86400.0 >= 15) {
        timeString = [self formatterTime:[NSNumber numberWithDouble:time.doubleValue]];
    }
    return timeString;
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 4;
    NSDictionary *attr = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}


@end
