//
//  MTHelp.m
//  MyTravel
//
//  Created by ysq on 16/1/20.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHelp.h"
#import "SQProgressHUD.h"

@implementation YSQHelp

+ (NSString * )GetPriceInStr:(NSString *)str{
    NSRange range = [str rangeOfString:@">"];
    NSString * substr = [str substringFromIndex:range.location+range.length];
    NSRange range1 = [substr rangeOfString:@"<"];
    NSString * endstr  = [substr substringToIndex:range1.location];
    return endstr;
}

+ (UIImage *)imageWithBgColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, WIDTH, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (void)networkActivityIndicatorVisible:(BOOL)visible toView:(UIView *)view{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
    if (visible) {
        [SQProgressHUD showHUDToView:view animated:YES];
    } else {
        [SQProgressHUD hideHUDToView:view animated:YES];
    }
}


+ (NSString *)matchString:(NSString *)str {
    if ([str isEqualToString:@"om"]) {
        return @"欧美国家";
    } else if ([str isEqualToString:@"dny"]) {
        return @"东南亚";
    } else if ([str isEqualToString:@"rh"]) {
        return @"日韩";
    } else if ([str isEqualToString:@"gat"]) {
        return @"港澳台";
    } else {
        return str;
    }
}

+ (NSString *)cutOutString:(NSString *)originString {
    for (NSUInteger index = originString.length - 1; index > 0 ; index --) {
        unichar str = [originString characterAtIndex:index];
        if (str == '/') {
            NSString *resultString = [originString substringFromIndex:index + 1];
            NSString *path = [NSString stringWithFormat:@"%@/Library",NSHomeDirectory()];
            NSString *result = [path stringByAppendingPathComponent:resultString];
            NSLog(@"%@",result);
            return result;
        }
    }
    return nil;
}

+ (NSString *)createUnZipPath:(NSString *)filePath {
    for (NSUInteger index = filePath.length - 1; index > 0 ; index --) {
        unichar str = [filePath characterAtIndex:index];
        if (str == '/') {
            NSMutableString *resultString = [[NSMutableString alloc]initWithString:[filePath substringFromIndex:index + 1]];
            NSRange range = [resultString rangeOfString:@".zip"];
            [resultString deleteCharactersInRange:NSMakeRange(range.location, range.length)];
            NSString *path = [NSString stringWithFormat:@"%@/Library",NSHomeDirectory()];
            NSString *result = [path stringByAppendingPathComponent:resultString];
            NSLog(@"%@",result);
            return result;
        }
    }
    return nil;
}

+ (void)clearNavShadow:(UIViewController *)vc isClear:(BOOL)clear{
    if (clear) {
        [vc.navigationController.navigationBar setShadowImage:[YSQHelp imageWithBgColor:[UIColor clearColor]]];
    } else {
        [vc.navigationController.navigationBar setShadowImage:nil];
    }
}

+ (void)shareToSecondsPlatWithURLString:(NSString *)urlString shareImage:(id)shareImage presentTargert:(id)presentTargert delegate:(id <UMSocialUIDelegate>)delegate{
    [UMSocialSnsService presentSnsIconSheetView:presentTargert
                                         appKey:@"5739311ae0f55a387100020c"
                                      shareText:urlString
                                     shareImage:shareImage
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
                                       delegate:delegate];
}

+ (NSString *)getDBPath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [path stringByAppendingPathComponent:@"cache.sqlite"];
    return dbPath;
}

@end
