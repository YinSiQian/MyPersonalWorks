//
//  YSQAllCityCell.m
//  MyTravel
//
//  Created by ysq on 16/3/23.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQAllCityCell.h"
#import "YSQAllCityModel.h"

@interface YSQAllCityCell ()

@property (nonatomic, strong) UILabel *scenicSpot;
@property (nonatomic, strong) UILabel *count_people;
@property (nonatomic, strong) UILabel *cnname;
@property (nonatomic, strong) UILabel *enname;
@property (nonatomic, strong) UIImageView *cityImage;

@end


@implementation YSQAllCityCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)setDataWithModel:(YSQAllCityModel *)model {
    self.scenicSpot.text = model.representative;
    if ([model.representative isEqualToString:@""]) {
        self.scenicSpot.text = @"没有代表景点";
    }
    self.cnname.text = model.catename;
    self.enname.text = model.catename_en;
    self.count_people.text = model.beenstr;
    [self.cityImage setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionProgressive];
}

- (void)createUI {
    
    self.contentView.layer.borderColor = [UIColor colorWithWhite:0.942 alpha:1.000].CGColor;
    self.contentView.layer.borderWidth = .5;
    
    self.scenicSpot = [UILabel new];
    self.scenicSpot.font = YSQSamllFont;
    self.scenicSpot.textColor = YSQSmallBlack;
    self.scenicSpot.numberOfLines = 2;
    [self.contentView addSubview:self.scenicSpot];
    
    self.count_people = [UILabel new];
    self.count_people.font = YSQSamllFont;
    self.count_people.textColor = YSQGray;
    [self.contentView addSubview:self.count_people];
    
    self.cityImage = [UIImageView new];
    self.cityImage.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.cityImage];
    
    self.cnname = [UILabel new];
    self.cnname.font = YSQSamllFont;
    self.cnname.textColor = [UIColor whiteColor];
    [self.cityImage addSubview:self.cnname];
    
    self.enname = [UILabel new];
    self.enname.font = YSQSamllFont;
    self.enname.textColor =  [UIColor whiteColor];
    [self.cityImage addSubview:self.enname];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    [self.scenicSpot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    [self.cityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.equalTo(@110);
    }];
    
    [self.count_people mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.top.equalTo(self.cityImage.mas_bottom).offset(10);
    }];
    
    CGFloat centerY =  self.cityImage.height / 2;
    [self.enname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cityImage.mas_centerX);
        make.centerY.equalTo(@(centerY + 10));
    }];
    
    [self.cnname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cityImage.mas_centerX);
        make.centerY.equalTo(@(centerY - 10));
    }];
}


@end
