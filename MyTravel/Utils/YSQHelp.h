//
//  MTHelp.h
//  MyTravel
//
//  Created by ysq on 16/1/20.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UMSocial.h"

@interface YSQHelp : NSObject
+ (NSString * )GetPriceInStr:(NSString *)str;

+ (void)networkActivityIndicatorVisible:(BOOL)visible toView:(UIView *)view;

+ (UIImage *)imageWithBgColor:(UIColor *)color;

+ (NSString *)cutOutString:(NSString *)originString;

+ (NSString *)matchString:(NSString *)str;

+ (NSString *)createUnZipPath:(NSString *)filePath;

+ (void)clearNavShadow:(UIViewController *)vc isClear:(BOOL)clear;

+ (void)shareToSecondsPlatWithURLString:(NSString *)urlString shareImage:(id)shareImage presentTargert:(id)presentTargert delegate:(id <UMSocialUIDelegate>)delegate;

+ (NSString *)getDBPath;
@end
