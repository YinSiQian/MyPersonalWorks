//
//  YSQForumCell.h
//  MyTravel
//
//  Created by ysq on 16/3/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQGroupModel;

@protocol YSQForumCellDelegate <NSObject>

- (void)pushToForumDetailWithModel:(YSQGroupModel *)model;

@end

@interface YSQForumCell : UITableViewCell

@property (nonatomic, copy) NSArray *groupArr;

@property (nonatomic, weak) id <YSQForumCellDelegate> delegate;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
