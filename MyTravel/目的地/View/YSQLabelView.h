//
//  YSQLabelView.h
//  MyTravel
//
//  Created by ysq on 16/2/5.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQLabelView;

@protocol YSQLabelViewDataSource <NSObject>

@optional

- (void)labelView:(YSQLabelView *)labelView didSelectedIndex:(NSInteger)index;

@end

@interface YSQLabelView : UIScrollView

@property (nonatomic, strong) NSArray *titleArray;

/**
 *  初始化ScrollView滑动卡
 *
 *  @param frame    scrollViewFrame
 *  @param array    选择标题
 *  @param delegate 代理委托
 *
 *  @return YSQLabelView
 */
+ (instancetype)labelView:(CGRect)frame titleArray:(NSArray *)array delegate:(id)delegate;

@property (nonatomic, weak) id <YSQLabelViewDataSource> datasource;

@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;




@end

