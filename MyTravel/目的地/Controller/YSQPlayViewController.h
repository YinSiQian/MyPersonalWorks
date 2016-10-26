//
//  YSQPlayViewController.h
//  MyTravel
//
//  Created by ysq on 16/3/2.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSQPlayViewController : UIViewController
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isPlay;


@end
