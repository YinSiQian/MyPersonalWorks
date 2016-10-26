//
//  YSQCommonHeaderCell.h
//  MyTravel
//
//  Created by ysq on 16/2/5.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSQCommonHeaderCellDelegate <NSObject>

@optional
- (void)seeAllInfomationWithIsFreedom:(BOOL)isFreedom;

@end

@interface YSQCommonHeaderCell : UITableViewCell
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIButton *seeAll;
@property (nonatomic, assign) BOOL isFreedom;
@property (nonatomic, weak) id <YSQCommonHeaderCellDelegate> delegate;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
