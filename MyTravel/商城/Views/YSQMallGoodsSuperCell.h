//
//  YSQMallGoodsSuperCell.h
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSQMallGoodsSuperCell : UITableViewCell
@property (nonatomic, copy) NSArray *modelArr;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
