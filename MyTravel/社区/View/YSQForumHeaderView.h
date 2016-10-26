//
//  YSQForumHeaderView.h
//  MyTravel
//
//  Created by ysq on 16/4/30.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQForumDetailModel;
@interface YSQForumHeaderView : UIView

- (void)setDataWithModel:(YSQForumDetailModel *)model;
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;

@end
