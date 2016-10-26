//
//  YSQTagView.h
//  MyTravel
//
//  Created by ysq on 16/8/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YSQTagViewDelegate <NSObject>

@optional

- (void)clickedBtn:(NSString *)currentTitle;

@end

@interface YSQTagView : UIView

+ (instancetype)initWithTagArr:(NSArray *)titleArr;

//返回整个View的高度
- (CGFloat)countHeight;

//离左侧间距
@property (nonatomic, assign) CGFloat widthToLeft;

//离右侧间距
@property (nonatomic, assign) CGFloat widthToRight;

//默认为blackColor
@property (nonatomic, strong) UIColor *titleColor;

//默认为greenColor
@property (nonatomic, strong) UIColor *borderColor;

//默认为0
@property (nonatomic, assign) CGFloat cornerRadius;

//边框宽度 默认为1
@property (nonatomic, assign) CGFloat borderWidth;

//点击按钮回调block
@property (nonatomic, copy) void (^didTagResponse)(NSString *currentTitle);

@property (nonatomic, weak) id <YSQTagViewDelegate> delegate;

@end
