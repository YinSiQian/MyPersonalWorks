//
//  YSQDiscountChooseView.h
//  MyTravel
//
//  Created by ysq on 16/4/15.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSQDiscountChooseViewDelegate <NSObject>

@optional

- (void)showMoreChoose:(NSInteger)index;

@end

@interface YSQDiscountChooseView : UIView

@property (nonatomic, weak) id <YSQDiscountChooseViewDelegate> delegate;


@end
