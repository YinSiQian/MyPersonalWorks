//
//  YSQSearchHeadView.m
//  MyTravel
//
//  Created by ysq on 16/8/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQSearchHeadView.h"

@implementation YSQSearchHeadView


- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title haveBtn:(BOOL)haveBtn{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor blackColor];
        label.text = title;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(10);
        }];

        if (haveBtn) {
            UIButton *btn = [[UIButton alloc]init];
            [btn setTitle:@"清除记录" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(-10);
            }];
        }
        
    }
    return self;
}

- (void)btnClick {
    if (self.callBack) {
        self.callBack();
    }
}

@end
