//
//  YSQKitsReusableView.m
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQKitsReusableView.h"

@interface YSQKitsReusableView ()


@end

@implementation YSQKitsReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createCell];
    }
    return self;
}

- (void)createCell {
    self.title = [UILabel new];
    self.title.font = YSQNormalFont;
    self.title.textColor = YSQSteel;
    [self addSubview:self.title];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
}

@end
