//
//  NSObject+YSQStore.h
//  MyTravel
//
//  Created by ysq on 16/3/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YSQStore)
- (void)storeValueWithKey:(NSString *)key;
+ (id)valueByKey:(NSString *)key;
@end
