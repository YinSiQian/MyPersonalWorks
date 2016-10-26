//
//  YSQSearchCell.h
//  MyTravel
//
//  Created by ysq on 16/8/28.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQSearchResultModel;

@interface YSQSearchCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setDataWithModel:(YSQSearchResultModel *)model;
@end
