//
//  NSObject+YSQStore.m
//  MyTravel
//
//  Created by ysq on 16/3/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "NSObject+YSQStore.h"
#import "YSQLocationStore.h"

@implementation NSObject (YSQStore)
- (void)storeValueWithKey:(NSString *)key {
    [[YSQLocationStore sharedInstance] storeValue:self withKey:key];
}

+ (id)valueByKey:(NSString *)key {
    return [[YSQLocationStore sharedInstance] valueWithKey:key];
}

@end
