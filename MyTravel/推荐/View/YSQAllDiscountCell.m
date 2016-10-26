//
//  YSQAllDiscountCell.m
//  MyTravel
//
//  Created by ysq on 16/4/14.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQAllDiscountCell.h"
#import "YSQAllDiscountModel.h"
@interface YSQAllDiscountCell ()

@property (nonatomic, strong) UILabel *priceOff;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIImageView *discountImage;


@end

@implementation YSQAllDiscountCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createCell];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.borderColor = [UIColor colorWithWhite:0.795 alpha:1.000].CGColor;
    self.layer.borderWidth = 0.4;
}

- (void)setDataWithModel:(YSQAllDiscountModel *)model {
    self.priceOff.text = model.lastminute_des;
    self.time.text = model.departureTime;
    self.title.text = model.title;
    [self.discountImage setImageWithURL:[NSURL URLWithString:model.pic] options:YYWebImageOptionProgressive];
    NSString *price =  [NSString stringWithFormat:@"%@元起",[YSQHelp GetPriceInStr:model.price]];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:price];
    [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(price.length -2, 2)];
    if ([price hasPrefix:@"Free"]) {
        self.price.text = @"Free";
    } else {
        self.price.attributedText =  attribute;
    }
}


- (void)createCell {
    self.price = [UILabel new];
    self.price.textAlignment = NSTextAlignmentRight;
    self.price.font = YSQSamllFont;
    self.price.textColor = YSQRed;
    [self.contentView addSubview:self.price];
    
    self.priceOff = [UILabel new];
    self.priceOff.textAlignment = NSTextAlignmentLeft;
    self.priceOff.font = YSQSamllFont;
    self.priceOff.textColor = YSQGray;
    [self.contentView addSubview:self.priceOff];
    
    self.time = [UILabel new];
    self.time.font = YSQSamllFont;
    self.time.textColor = YSQGray;
    [self.contentView addSubview:self.time];
    
    self.title = [UILabel new];
    self.title.font = YSQNormalFont;
    self.title.textColor = YSQBlack;
    self.title.numberOfLines = 2;
    [self.contentView addSubview:self.title];

    self.discountImage = [UIImageView new];
    [self.contentView addSubview:self.discountImage];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    [self.priceOff mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(self).offset(-5);
    }];

    [self.discountImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.equalTo(@100);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.top.equalTo(self.discountImage.mas_bottom).offset(5);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self.title.mas_bottom).offset(5);
    }];
}

@end
