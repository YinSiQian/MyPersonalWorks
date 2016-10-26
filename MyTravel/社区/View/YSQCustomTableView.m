//
//  YSQCustomTableView.m
//  MyTravel
//
//  Created by ysq on 2016/10/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQCustomTableView.h"

@implementation YSQCustomTableView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.tableHeaderView && CGRectContainsPoint(self.tableHeaderView.frame, point)) {
        return NO;
        
    }
    return [super pointInside:point withEvent:event];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
