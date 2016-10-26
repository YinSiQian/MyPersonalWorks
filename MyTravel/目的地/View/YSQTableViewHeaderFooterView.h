//
//  YSQTableViewHeaderFooterView.h
//  MyTravel
//
//  Created by ysq on 16/2/5.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YSQCountryDetail;

@protocol YSQTableViewHeaderFooterViewDelegate <NSObject>



@end


@interface YSQTableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, assign) BOOL isCity;
@property (nonatomic, weak) id <YSQTableViewHeaderFooterViewDelegate> delegate;


- (void)setDataWithModel:(YSQCountryDetail *)model;

+ (YSQTableViewHeaderFooterView *)headerFooterView;




@end
