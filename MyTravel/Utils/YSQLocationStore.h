//
//  ODStoreUserInfo.h
//  oudaBuyer
//
//  Created by ysq on 15/12/2.
//  Copyright © 2015年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQLocationStore : NSObject

+ (YSQLocationStore *)sharedInstance;

- (void)storeValue:(id)value withKey:(NSString *)key;
- (id)valueWithKey:(NSString *)key;

@end
