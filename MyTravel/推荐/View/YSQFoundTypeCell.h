//
//  MTFoundTypeCell.h
//  MyTravel
//
//  Created by ysq on 16/1/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YSQHotCity;
@protocol YSQFoundTypeCellDelegate <NSObject>

- (void)showDetailWithURL:(NSString *)url;
@end

@protocol YSQFoundTypeCellHotDelegate <NSObject>

- (void)showCityDetailWithModel:(YSQHotCity *)model;

@end

@interface YSQFoundTypeCell : UITableViewCell

@property (nonatomic, weak) id <YSQFoundTypeCellDelegate> delegate;
@property (nonatomic, weak) id <YSQFoundTypeCellHotDelegate> hotDelegate;

- (void)setDataWithArray:(NSArray *)array;

/**
 *  目的地国家详情热门城市调用该方法
 *
 *  @param model 热门城市数据模型
 */
- (void)setDataWithLeftModel:(YSQHotCity *)model;

- (void)setDataWithRightModel:(YSQHotCity *)model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
