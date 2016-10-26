//
//  UIImageView+YSQAdd.m
//  MyTravel
//
//  Created by ysq on 2016/10/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "UIImageView+YSQAdd.h"

@implementation UIImageView (YSQAdd)

- (void)playGifAnimation:(NSArray *)imageArr {
    //对图片数组进行校验
    for (id image in imageArr) {
        if (![image isKindOfClass:[UIImage class]]) {
            NSLog(@"请检查数组元素是否全都为UIImage");
            return;
        }
    }
    if (imageArr.count == 0) {
        return;
    }
    self.animationImages = imageArr;
    self.animationDuration = 0.5;
    self.animationRepeatCount = 0;//0表示无限循环
    [self startAnimating];
}

- (void)stopGifAnimation {
    if (self.isAnimating) {
        [self stopAnimating];
    }
    [self removeFromSuperview];
}

@end
