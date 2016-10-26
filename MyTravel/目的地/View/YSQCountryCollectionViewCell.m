//
//  YSQCountryCollectionViewCell.m
//  MyTravel
//
//  Created by ysq on 16/2/7.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQCountryCollectionViewCell.h"
#import "YSQCountry.h"

@interface YSQCountryCollectionViewCell ()

@property (nonatomic, strong) UIImageView *countryView;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UILabel *city_count;
@property (nonatomic, strong) UILabel *city;
@property (nonatomic, strong) UILabel *enname;
@property (nonatomic, strong) UILabel *cnname;

@property (nonatomic, assign) CGFloat Height;
@property (nonatomic, assign) CGFloat Width;

@end

@implementation YSQCountryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self  createCell];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createCell {
    self.countryView = [UIImageView new];
    [self.contentView addSubview:self.countryView];
    
    self.grayView = [UIView new];
    self.grayView.backgroundColor = [UIColor blackColor];
    self.grayView.alpha = 0.5;
    [self.contentView addSubview:self.grayView];
    
    self.city_count = [UILabel new];
    self.city_count.font = [UIFont systemFontOfSize:16];
    self.city_count.textColor = [UIColor whiteColor];
    self.city_count.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.city_count];
    
    self.city = [UILabel new];
    self.city.font = [UIFont systemFontOfSize:16];
    self.city.textColor = [UIColor whiteColor];
    self.city.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.city];

    self.enname = [UILabel new];
    self.enname.font = [UIFont systemFontOfSize:12];
    self.enname.textColor = [UIColor whiteColor];
    self.enname.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.enname];

    self.cnname = [UILabel new];
    self.cnname.font = [UIFont boldSystemFontOfSize:14];
    self.cnname.textColor = [UIColor whiteColor];
    self.cnname.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.cnname];
   
    [self makeConstraint];
}

- (void)makeConstraint {
    [self.countryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
    }];
    
    [self.city_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.grayView.mas_top).offset(3);
        make.left.equalTo(self.grayView.mas_left).offset(0);
        make.right.equalTo(self.grayView.mas_right).offset(0);
    }];
    
    [self.city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.grayView.mas_centerX);
        make.top.equalTo(self.city_count.mas_bottom).offset(3);
    }];
    
    [self.cnname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self.enname.mas_top).offset(-5);
    }];
    
    [self.enname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
    }];
}

- (void)setDataWithModel:(YSQCountry *)model {
    self.cnname.text = model.cnname;
    self.enname.text = model.enname;
    self.city.text = model.label;
    self.city_count.text = [NSString stringWithFormat:@"%@",model.count];
    [self.countryView setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionProgressive];
    CGFloat width1 = [NSString sizeWithText:self.city_count.text font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(WIDTH, 40)].width;
    CGFloat height1 = [NSString sizeWithText:self.city_count.text font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(WIDTH, 40)].height;
    
    CGFloat width2 = [NSString sizeWithText:self.city.text font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(WIDTH, 40)].width;
    CGFloat height2 = [NSString sizeWithText:self.city.text font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(WIDTH, 40)].height;
    
    self.Width = width1 > width2 ? width1 + 8 :width2 + 8;
    self.Height = height1 + height2 + 8;
    self.grayView.frame = CGRectMake(self.width - self.Width - 10, 10, self.Width, self.Height);

}


@end
