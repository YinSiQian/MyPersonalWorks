//
//  YSQAskCell.h
//  MyTravel
//
//  Created by ysq on 16/4/29.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YSQCompanyModel;
@class YSQAskModel;
@interface YSQAskCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setDataWithModel:(YSQAskModel *)model;
- (void)setDataWithCMModel:(YSQCompanyModel *)model;


@end
