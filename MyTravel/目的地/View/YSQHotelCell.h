//
//  YSQHotelCell.h
//  MyTravel
//
//  Created by ysq on 16/3/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQCityHotelModel;

@interface YSQHotelCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setDataWithModel:(YSQCityHotelModel *)model;
@end
