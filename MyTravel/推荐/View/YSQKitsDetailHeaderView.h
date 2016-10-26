//
//  YSQKitsDetailHeaderView.h
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQKitsDetailModel;

@interface YSQKitsDetailHeaderView : UIView
@property (nonatomic, strong) UIImageView *imageView;

- (void)setDataWithModel:(YSQKitsDetailModel *)model;

@end
