//
//  YSQMarketCell.h
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSQMarketCellDelegate <NSObject>

- (void)seeRecommend:(NSString *)url;

@end

@interface YSQMarketCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSArray *modelArr;

@property (nonatomic, weak) id <YSQMarketCellDelegate> delegate;


@end
