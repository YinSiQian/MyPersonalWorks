//
//  YSQScenicSpotCell.h
//  MyTravel
//
//  Created by ysq on 16/6/27.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQCityMapModel;

@protocol YSQScenicSpotCellDelegate <NSObject>
//调起高德地图
- (void)wakeUpMAMapToNavigation:(NSInteger)index;

@end

@interface YSQScenicSpotCell : UICollectionViewCell
- (void)setDataWithModel:(YSQCityMapModel *)model;
@property (nonatomic, weak) id <YSQScenicSpotCellDelegate> delegate;
@end
