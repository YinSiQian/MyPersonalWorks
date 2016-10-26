//
//  YSQFooterView.m
//  MyTravel
//
//  Created by ysq on 16/3/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQFooterView.h"

@interface YSQFooterView ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation YSQFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        self.btn = [UIButton new];
        [self.btn setTitleColor:[UIColor colorWithRed:0.000 green:0.690 blue:0.000 alpha:1.000] forState:UIControlStateNormal];
        self.btn.titleLabel.font = YSQNormalFont;
        [self.btn addTarget:self action:@selector(seeTopic) forControlEvents:UIControlEventTouchUpInside];
        [self.btn setTitle:@"查看更多 >" forState:UIControlStateNormal];
        [self addSubview:self.btn];
        
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000];
        [self addSubview:label];
        
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.top.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(-10);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.top.equalTo(self.btn.mas_bottom).offset(0);
            make.bottom.equalTo(self).offset(0);
        }];
    }
    return self;
}

- (void)seeTopic {
    if (self.seeMoreTopic) {
        self.seeMoreTopic(self.type);
    }
}

@end
