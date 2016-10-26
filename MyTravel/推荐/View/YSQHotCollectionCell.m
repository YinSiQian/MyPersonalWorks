//
//  YSQHotCollectionCell.m
//  MyTravel
//
//  Created by ysq on 16/5/24.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotCollectionCell.h"
#import "YSQAddressModel.h"

@interface YSQHotCollectionCell ()

@property (nonatomic, strong) UILabel *cnname;
@property (nonatomic, strong) UILabel *enname;

@end

@implementation YSQHotCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createCell];
        [self makeConstraints];
        self.layer.borderColor = YSQGray.CGColor;
        self.layer.borderWidth = 0.5;
    }
    return self;
}

- (void)setDataWithModel:(YSQAddressModel *)model {
    self.cnname.text = model.cnname;
    self.enname.text = model.enname;
}

- (void)createCell {
    self.cnname = [UILabel new];
    self.cnname.textColor = YSQSteel;
    self.cnname.font = YSQNormalFont;
    [self.contentView addSubview:self.cnname];
    
    self.enname = [UILabel new];
    self.enname.textColor = YSQGray;
    self.enname.font = YSQLittleFont;
    [self.contentView addSubview:self.enname];
}

- (void)makeConstraints {
    [self.cnname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
    }];
    
    [self.enname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-10);
    }];
}

@end
