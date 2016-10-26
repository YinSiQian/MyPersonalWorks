//
//  YSQRelatedCell.h
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQRelateModel;

@interface YSQRelatedCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setDataWithModel:(YSQRelateModel *)model;

@end
