//
//  YSQCityChooseView.h
//  MyTravel
//
//  Created by ysq on 16/4/20.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSQCityChooseViewDelegate <NSObject>

- (void)sendCityValue:(NSNumber *)continetID countryID:(NSNumber *)countryID;

- (void)changedBarItemStatus;

@end

@interface YSQCityChooseView : UIView

@property (nonatomic, weak) id <YSQCityChooseViewDelegate> delegate;

+ (instancetype)initWithDataArray:(NSArray *)dataArray;

@end
