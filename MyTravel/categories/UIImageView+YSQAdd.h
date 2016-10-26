//
//  UIImageView+YSQAdd.h
//  MyTravel
//
//  Created by ysq on 2016/10/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (YSQAdd)
//播放Gif
- (void)playGifAnimation:(NSArray *)imageArr;

//停止
- (void)stopGifAnimation;
@end
