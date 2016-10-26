//
//  MTWebViewController.h
//  MyTravel
//
//  Created by ysq on 16/1/22.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface YSQWebViewController : UIViewController
@property (nonatomic, copy) NSString *url;
//折扣跳转
@property (nonatomic, strong) NSNumber *ID;


@end
