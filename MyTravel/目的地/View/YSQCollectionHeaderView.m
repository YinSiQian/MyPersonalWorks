//
//  YSQCollectionHeaderView.m
//  MyTravel
//
//  Created by ysq on 16/4/21.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQCollectionHeaderView.h"

@implementation YSQCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createCell];
    }
    return self;
}

- (void)createCell {
    self.title = [UILabel new];
    self.title.textColor = YSQSteel;
    self.title.font = YSQNormalFont;
    self.title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.title];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
    }];
}

@end
