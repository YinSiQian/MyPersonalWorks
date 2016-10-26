//
//  NSObject+YSQCache.m
//  MyTravel
//
//  Created by ysq on 16/8/1.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "NSObject+YSQCache.h"
#import "FMDB.h"

@interface NSObject ()

@property (nonatomic, assign) int page;

@end

@implementation NSObject (YSQCache)
+ (BOOL)storeDataToSQL:(id)data key:(NSString *)key {
    return YES;
}

- (void)storeData:(id)data key:(NSString *)key {
    
}

@end
