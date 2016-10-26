//
//  YSQSearchHeadView.h
//  MyTravel
//
//  Created by ysq on 16/8/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSQSearchHeadView : UIView

@property (nonatomic, copy) void (^callBack)();
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title haveBtn:(BOOL)haveBtn;

@end
