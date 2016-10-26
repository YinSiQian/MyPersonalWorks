//
//  MTDiscountCell.h
//  MyTravel
//
//  Created by ysq on 16/1/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSQDiscountModel;
@class YSQNewDiscount;
@protocol YSQDiscountCellDelegate <NSObject>
@required
- (void)showDiscountDetailWithID:(NSNumber *)ID;
@end

@interface YSQDiscountCell : UITableViewCell
@property (nonatomic, weak) id <YSQDiscountCellDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setDataWithLeftModel:(YSQDiscountModel *)model;
- (void)setDataWithRightModel:(YSQDiscountModel *)model;

//目的地城市详情的热门当地游调用
- (void)setLocalDataWithLeftModel:(YSQNewDiscount *)model;
- (void)setLocalDataWithRightModel:(YSQNewDiscount *)model;
@end
