//
//  YSQRequst.m
//  DSDoctor
//
//  Created by ysq on 15/11/25.
//  Copyright © 2015年 datapush. All rights reserved.
//

#import "NetWorkManager.h"
#import "AFAppDotNetAPIClient.h"

@interface NetWorkManager ()

@property (nonatomic, strong) NSURLSessionDownloadTask *downTask;

@end


@implementation NetWorkManager

+ (NSURLSessionTask *)getDataWithURL:(NSString *)url success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure  {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    return [[AFAppDotNetAPIClient sharedClient] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(error);
    }];

}

+ (NSURLSessionTask *)POST:(NSString *)urlString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    return [[AFAppDotNetAPIClient sharedClient] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(error);
    }];
}


+ (NSURLSessionDownloadTask *)download:(NSString *)urlString progress:(progressCallBack)progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSDate *startTime = [NSDate date];
    NetWorkManager *net = [[NetWorkManager alloc]init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDownloadTask *task = [[AFAppDotNetAPIClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSString *speed = [NSString stringWithFormat:@"下载速度:%@",[net downloadSpeed:startTime completedUnitCount:downloadProgress.completedUnitCount]];
        CGFloat percentage = downloadProgress.completedUnitCount / (CGFloat)downloadProgress.totalUnitCount;
         progress(percentage,speed);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *path = [NSString stringWithFormat:@"%@/Library",NSHomeDirectory()];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *filePath = [path stringByAppendingPathComponent:response.suggestedFilename];
        NSURL *url = [NSURL fileURLWithPath:filePath];
        return url;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //完成后的处理
        //failure(error);
    }];
    [task resume];
    return task;
}

- (NSString *)downloadSpeed:(NSDate *)startTime completedUnitCount:(int64_t)unitCount{
    NSTimeInterval startSeconds = [startTime timeIntervalSince1970];
    NSDate *now = [NSDate date];
    NSTimeInterval nowSeconds = [now timeIntervalSince1970];
    NSTimeInterval seconds = nowSeconds - startSeconds + 1;
    CGFloat speed = unitCount / seconds / 1000;
    if (speed < 1000) {
        return [NSString stringWithFormat:@"%.2f  kb/s",speed];
    } else {
        return [NSString stringWithFormat:@"%.1f m/s",speed / 1000];
    }
    
    
}

@end
