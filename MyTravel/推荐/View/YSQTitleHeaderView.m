//
//  YSQTitleHeaderView.m
//  MyTravel
//
//  Created by ysq on 16/3/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQTitleHeaderView.h"

@implementation YSQTitleHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.title = [UILabel new];
        self.title.font = YSQNormalFont;
        self.title.textColor = YSQSteel;
        [self addSubview:self.title];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(10);
        }];
        
    }
    return self;
}



@end
