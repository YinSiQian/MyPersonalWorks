//
//  YSQHotBBSCell.h
//  MyTravel
//
//  Created by ysq on 16/6/16.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQHotBBSModel;
@interface YSQHotBBSCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setDataWithModel:(YSQHotBBSModel *)model;


@end
