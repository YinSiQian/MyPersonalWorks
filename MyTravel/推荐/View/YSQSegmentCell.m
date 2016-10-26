//
//  YSQSegmentCell.m
//  MyTravel
//
//  Created by ysq on 16/4/15.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQSegmentCell.h"

@implementation YSQSegmentCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createCell];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.borderColor = [UIColor colorWithWhite:0.745 alpha:1.000].CGColor;
    self.layer.borderWidth = 0.3;
}

- (void)createCell {
    self.title = [UILabel new];
    self.title.textColor = YSQSteel;
    self.title.font = YSQSamllFont;
    self.title.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.title];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
}
@end
