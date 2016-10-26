//
//  YSQLocationHeaderView.m
//  MyTravel
//
//  Created by ysq on 16/3/3.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQLocationHeaderView.h"

@interface YSQLocationHeaderView ()

@end

@implementation YSQLocationHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        [self addGestureRecognizer];
    }
    return self;
}

- (void)addGestureRecognizer {
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeChoose)];
    [self addGestureRecognizer:tag];
}

- (void)createUI {
    self.title = [UILabel new];
    self.title.font = YSQSamllFont;
    [self addSubview:self.title];
    
    self.go = [UILabel new];
    self.go.font = YSQSamllFont;
    self.go.text = @"Let's go!";
    [self addSubview:self.go];
    
    [self makeConstraint];
}

- (void)makeConstraint {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self.go mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
}

- (void)seeChoose {
    if ([self.delegate respondsToSelector:@selector(seeBoardChoose)]) {
        [self.delegate seeBoardChoose];
    }
}

@end
