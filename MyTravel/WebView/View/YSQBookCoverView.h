//
//  YSQBookCoverView.h
//  MyTravel
//
//  Created by ysq on 16/6/14.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YSQBookCoverView : UIView


- (void)loadCoverImage:(NSString *)coverPath titleImage:(NSString *)titlePath;

- (void)starAnimation:(void(^)(YSQBookCoverView *cover))completion;
@end
