//
//  YSQPlayCell.h
//  MyTravel
//
//  Created by ysq on 16/3/2.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQPlayModel;

@protocol YSQPlayCellDelegate <NSObject>

@optional

- (void)loveWithIndex:(NSInteger)index isLove:(BOOL)isLove;

@end


@interface YSQPlayCell : UITableViewCell

@property (nonatomic, weak) id <YSQPlayCellDelegate> delegate;

@property (nonatomic, assign) BOOL isShow;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setDataWithModel:(YSQPlayModel *)model;
@end
