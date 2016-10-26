//
//  YSQNewInfoCell.h
//  MyTravel
//
//  Created by ysq on 16/4/29.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQEntryModel;
@interface YSQNewInfoCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setDataWithModel:(YSQEntryModel *)model;

@end
