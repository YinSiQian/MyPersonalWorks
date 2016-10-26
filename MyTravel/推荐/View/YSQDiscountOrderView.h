//
//  YSQDiscountOrderView.h
//  MyTravel
//
//  Created by ysq on 16/4/14.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YSQDiscountOrderViewDelegate <NSObject>

@optional

- (void)orderDiscountInfoWithType:(NSString *)type;


- (void)chooseDataWithArr:(NSArray *)modelArr;

@end

@protocol YSQDiscountOrderViewStatusChangedDelegate <NSObject>

- (void)changedButtonSelected;

@end

@protocol YSQDiscountOrderViewDataSource <NSObject>

@optional
- (void)sendDataInDict:(NSDictionary *)dataDict;

@end

@interface YSQDiscountOrderView : UIView

@property (nonatomic, weak) id <YSQDiscountOrderViewDelegate> delegate;
@property (nonatomic, weak) id <YSQDiscountOrderViewStatusChangedDelegate> statusDelegate;
@property (nonatomic, weak) id <YSQDiscountOrderViewDataSource> dataSource;

+ (instancetype)initWithTitlesArray:(NSArray *)arr;

+ (instancetype)initWithModelArray:(NSArray *)modelArray;

@end
