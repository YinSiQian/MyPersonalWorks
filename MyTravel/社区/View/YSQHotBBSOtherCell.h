//
//  YSQHotBBSOtherCell.h
//  MyTravel
//
//  Created by ysq on 16/6/18.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSQHotBBSModel;
@interface YSQHotBBSOtherCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setDataWithModel:(YSQHotBBSModel *)model;
@end
