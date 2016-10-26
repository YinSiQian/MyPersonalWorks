//
//  YSQFreedomCell.h
//  MyTravel
//
//  Created by ysq on 16/2/5.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQNewDiscount;
@interface YSQFreedomCell : UITableViewCell
- (void)setDataWithModel:(YSQNewDiscount *)model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
