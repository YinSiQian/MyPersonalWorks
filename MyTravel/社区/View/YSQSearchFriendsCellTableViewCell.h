//
//  YSQSearchFriendsCellTableViewCell.h
//  MyTravel
//
//  Created by ysq on 16/6/17.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSQCompanyModel;
@interface YSQSearchFriendsCellTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setDataWithModel:(YSQCompanyModel *)model;
@end
