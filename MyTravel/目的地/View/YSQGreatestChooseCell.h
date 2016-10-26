//
//  YSQGreatestChooseCell.h
//  MyTravel
//
//  Created by ysq on 16/3/2.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQGreatestSelectModel;

@interface YSQGreatestChooseCell : UITableViewCell

- (void)setDataWithModel:(YSQGreatestSelectModel *)model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
