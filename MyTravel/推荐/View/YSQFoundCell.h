//
//  MTFoundCell.h
//  MyTravel
//
//  Created by ysq on 16/1/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSQNewDiscount;
@interface YSQFoundCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setDataWithModel:(YSQNewDiscount *)model;

@end
