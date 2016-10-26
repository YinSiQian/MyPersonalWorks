//
//  YSQMallDiscountHeaderCell.h
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSQMallDiscountHeaderCell : UITableViewCell

@property (nonatomic, copy) NSDictionary *topic;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
