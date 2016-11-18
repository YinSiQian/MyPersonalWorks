//
//  UIViewController+YSQAdd.m
//  MyTravel
//
//  Created by 尹思迁 on 2016/11/17.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "UIViewController+YSQAdd.h"
#import <objc/runtime.h>

@implementation UIViewController (YSQAdd)



- (void)setForbidPop:(BOOL)forbidPop {
    objc_setAssociatedObject(self, @selector(forbidPop), @(forbidPop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)forbidPop {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
