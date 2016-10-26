//
//  YSQHotAreaCell.h
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSQHotAreaModel;


@protocol YSQHotAreaCellDelegate <NSObject>

- (void)seeHotCountry:(NSString *)countryID;

- (void)seeAreaTopic:(NSString *)type;

- (void)seeDiscountDetail:(NSString *)ID;

@end

@interface YSQHotAreaCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setDataModel:(YSQHotAreaModel *)model;
@property (nonatomic, weak) id <YSQHotAreaCellDelegate> delegate;


@end
