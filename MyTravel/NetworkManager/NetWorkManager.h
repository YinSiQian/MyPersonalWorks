//
//  YSQRequst.h
//  DSDoctor
//
//  Created by ysq on 15/11/25.
//  Copyright © 2015年 datapush. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^progressCallBack)(CGFloat progress, NSString *downloadSpeed);

@interface NetWorkManager : NSObject

@property (nonatomic, copy) progressCallBack proCallBack;

+ (NSURLSessionTask *)getDataWithURL:(NSString *)url success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (NSURLSessionTask *)POST:(NSString *)urlString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (NSURLSessionDownloadTask *)download:(NSString *)urlString  progress:(progressCallBack)progress  success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
