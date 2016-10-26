//
//  YSQTopFlagView.m
//  MyTravel
//
//  Created by ysq on 16/4/29.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQTopFlagView.h"

@implementation YSQTopFlagView

- (instancetype)initWithFlag:(NSString *)flag {
    if (self = [super init]) {
        self.text = flag;
        self.textColor = [UIColor whiteColor];
        self.font = YSQLittleFont;
        self.frame = CGRectMake(0, 0, 40, 14);
        self.backgroundColor = [UIColor colorWithRed:1.000 green:0.172 blue:0.319 alpha:1.000];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
}

@end
