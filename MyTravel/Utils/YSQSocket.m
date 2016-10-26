//
//  YSQSocket.m
//  MyTravel
//
//  Created by ysq on 2016/10/14.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQSocket.h"
#import "GCDAsyncSocket.h"

@interface YSQSocket ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *socket;

@property (nonatomic, copy) NSString *socketHost;

@property (nonatomic, assign) uint16_t socketPort;

@property (nonatomic, strong) NSTimer *longConnectTimer;

@property (nonatomic, assign) SQSocketCutType cutType;

@end

@implementation YSQSocket

+ (instancetype)shareSocket {
    static YSQSocket *socket = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socket = [[self alloc]init];
    });
    return socket;
}

- (instancetype)init {
    if (self = [super init]) {
        self.socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    }
    return self;
}

- (void)startConneted:(NSString *)host onPort:(uint16_t)port {
    self.socketHost = host;
    self.socketPort = port;
    NSError *error = nil;
    //判断是否已经连接
    if (self.socket.isDisconnected) {
        [self.socket connectToHost:self.socketHost onPort:self.socketPort error:&error];
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
    } else {
        [self.socket disconnect];
        [self.socket connectToHost:self.socketHost onPort:self.socketPort error:&error];
    }
    [self.socket connectToHost:self.socketHost onPort:self.socketPort error:&error];
}

- (void)longConnectToSocket {
    NSString *longConnect = @"isLongConnect";
    NSData *dataStream = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:dataStream withTimeout:-1 tag:0];
}

- (void)cutConnect {
    self.cutType = SQSocketUserCut;
    [self.socket disconnect];
}

- (void)sendMessage:(NSString *)msg {
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:1];
}


- (void)socketRestartConnect:(GCDAsyncSocket *)socket {
}

- (void)socket:(GCDAsyncSocket *)socket didConnectToHost:(NSString *)host port:(uint16_t)port {
    //每隔一段时间向服务器发送心跳包
    self.longConnectTimer = [NSTimer timerWithTimeInterval:30 block:^(NSTimer * _Nonnull timer) {
        NSString *longConnect = @"isLongConnect";
        NSData *dataStream = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
        [self.socket writeData:dataStream withTimeout:-1 tag:0];
    } repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.longConnectTimer forMode:NSRunLoopCommonModes];
    [self.longConnectTimer fire];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
     NSLog(@" willDisconnectWithError %@   err = %@",sock.userData,[err description]);
    if (err.code == 57) {
        self.cutType = SQSocketNetworkCut;
        //self.socket.userData =
    }
}

//消息发送成功的回调
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    NSLog(@"send message true");
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",msg);
}






@end
