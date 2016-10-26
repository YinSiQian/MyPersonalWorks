//
//  MTBannerCell.h
//  MyTravel
//
//  Created by ysq on 16/1/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSQRecommendModel;

typedef NS_ENUM(NSUInteger, YSQTraveServiceType) {
    YSQTravelStrategyService,
    YSQTravelDiscountService,
    YSQTravelHotelService,
    YSQTravelLocationService,
};

@protocol YSQBannerCellDelegate <NSObject>

- (void)seeTravelService:(YSQTraveServiceType)service;

- (void)goToBannerDetailWithURL:(NSString *)url;

@end
@interface YSQBannerCell : UITableViewCell

@property (nonatomic, weak) id <YSQBannerCellDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setAutoScrollViewWithModel:(YSQRecommendModel *)model;
@end
