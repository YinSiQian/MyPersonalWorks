//
//  YSQMallDiscountCell.h
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQMallListModel;
@interface YSQMallDiscountCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setDataWithModel:(YSQMallListModel *)model;
@end
