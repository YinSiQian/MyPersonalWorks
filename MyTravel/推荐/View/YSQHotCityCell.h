//
//  YSQHotCityCell.h
//  MyTravel
//
//  Created by ysq on 16/5/24.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQAddressModel;
@interface YSQHotCityCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView ;

@property (nonatomic, copy) NSArray *dataArr;

@end

