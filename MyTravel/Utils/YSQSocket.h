//
//  YSQSocket.h
//  MyTravel
//
//  Created by ysq on 2016/10/14.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCDAsyncSocket;

typedef NS_ENUM(NSInteger, SQSocketCutType ) {
    SQSocketUserCut,
    SQSocketSeverCut,
    SQSocketNetworkCut
};

@interface YSQSocket : NSObject

@property (nonatomic, strong, readonly) GCDAsyncSocket *socket;

@property (nonatomic, copy, readonly) NSString *socketHost;

@property (nonatomic, assign, readonly) uint16_t socketPort;

+ (instancetype)shareSocket;

- (void)startConneted:(NSString *)host onPort:(uint16_t)port;

- (void)sendMessage:(NSString *)msg;

@end
