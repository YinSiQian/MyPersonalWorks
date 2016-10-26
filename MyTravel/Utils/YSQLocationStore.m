//
//  ODStoreUserInfo.m
//  oudaBuyer
//
//  Created by ysq on 15/12/2.
//  Copyright © 2015年 ysq. All rights reserved.
//

#import "YSQLocationStore.h"
#import "FastCoder.h"

@implementation YSQLocationStore

+ (YSQLocationStore *)sharedInstance {
    
    static YSQLocationStore *storeValue = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        storeValue = [[YSQLocationStore alloc] init];
    });
    
    return storeValue;
}

- (void)storeValue:(id)value withKey:(NSString *)key {
    
    //值为空则崩溃
    NSParameterAssert(value);
    NSParameterAssert(key);
    
    NSData *data = [FastCoder dataWithRootObject:value];
    if (data) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    }
}

- (id)valueWithKey:(NSString *)key {
    
    NSParameterAssert(key);
    
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    
    return [FastCoder objectWithData:data];
}


@end
