//
//  YSQMineHeaderView.h
//  MyTravel
//
//  Created by ysq on 16/5/28.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSQMineHeaderView : UIView
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIButton *icon;
@property (nonatomic, strong) UILabel *name;

- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;
@end
