//
//  YSQNormalCountryCell.m
//  MyTravel
//
//  Created by ysq on 16/2/7.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQNormalCountryCell.h"
#import "YSQCountry.h"

@interface YSQNormalCountryCell ()

@property (nonatomic, strong) UILabel *cnname;
@property (nonatomic, strong) UILabel *enname;
@property (nonatomic, strong) UIView *line;

@end

@implementation YSQNormalCountryCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createCell];
    }
    return self;
}

- (void)createCell {
    self.cnname = [UILabel new];
    self.cnname.font = [UIFont systemFontOfSize:14];
    self.cnname.textColor = [UIColor colorWithWhite:0.200 alpha:1.000];
    [self.contentView addSubview:self.cnname];
    
    self.enname = [UILabel new];
    self.enname.font = [UIFont systemFontOfSize:12];
    self.enname.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
    [self.contentView addSubview:self.enname];
    
    self.line = [UIView new];
    self.line.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [self.contentView addSubview:self.line];

    [self makeConstraint];
}

- (void)makeConstraint {
    [self.cnname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self.enname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cnname.mas_right).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.equalTo(@.5);
    }];
}

- (void)setDataWithModel:(YSQCountry *)model {
    self.cnname.text = model.cnname;
    self.enname.text = model.enname;
}
@end
