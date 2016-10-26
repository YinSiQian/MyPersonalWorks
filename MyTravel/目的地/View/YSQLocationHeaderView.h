//
//  YSQLocationHeaderView.h
//  MyTravel
//
//  Created by ysq on 16/3/3.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YSQLocationHeaderViewDelegate <NSObject>

- (void)seeBoardChoose;

@end

@interface YSQLocationHeaderView : UIView

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *go;

@property (nonatomic, weak) id <YSQLocationHeaderViewDelegate> delegate;


@end
