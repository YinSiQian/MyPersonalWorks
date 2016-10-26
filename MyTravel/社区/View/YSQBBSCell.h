//
//  YSQBBSCell.h
//  MyTravel
//
//  Created by ysq on 16/6/17.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSQGroupModel;
@interface YSQBBSCell : UITableViewCell

- (void)setDataWithModel:(YSQGroupModel *)model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
