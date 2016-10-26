//
//  YSQCityLocationCell.h
//  MyTravel
//
//  Created by ysq on 16/2/12.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSQCityLocationCellDelegate <NSObject>

@optional

- (void)goToLocalFeaturesWithIndex:(int)index;

@end

@interface YSQCityLocationCell : UITableViewCell

@property (nonatomic, weak) id <YSQCityLocationCellDelegate> delegate;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
