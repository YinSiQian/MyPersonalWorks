//
//  YSQTableViewHeaderFooterView.m
//  MyTravel
//
//  Created by ysq on 16/2/5.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQTableViewHeaderFooterView.h"
#import "YSQCountryDetail.h"

@interface YSQTableViewHeaderFooterView ()

@property (nonatomic, strong) UILabel *cnCountry;
@property (nonatomic, strong) UILabel *enCountry;
@property (nonatomic, strong) UILabel *des;
@property (nonatomic, strong) UIButton *countryInfo;
@property (nonatomic, strong) SDCycleScrollView *scrollView;

@end

@implementation YSQTableViewHeaderFooterView

+ (YSQTableViewHeaderFooterView *)headerFooterView {
    YSQTableViewHeaderFooterView *header = [[YSQTableViewHeaderFooterView alloc]init];
    header.autoresizesSubviews = YES;;
    return header;
}

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.enCountry = [UILabel new];
    self.enCountry.font = [UIFont systemFontOfSize:12];
    self.enCountry.textColor = [UIColor whiteColor];
    [self addSubview:self.enCountry];
    
    self.cnCountry = [UILabel new];
    self.cnCountry.font = [UIFont boldSystemFontOfSize:14];
    self.cnCountry.textColor = [UIColor whiteColor];
    [self addSubview:self.cnCountry];
    
    self.des = [UILabel new];
    self.des.font = [UIFont systemFontOfSize:10];
    self.des.textColor = [UIColor whiteColor];
    self.des.numberOfLines = 2;
    [self addSubview:self.des];
    
    self.countryInfo = [UIButton new];
    self.countryInfo.titleLabel.textAlignment = NSTextAlignmentRight;
    self.countryInfo.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [self.countryInfo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.countryInfo addTarget:self action:@selector(goToCountryDesInfo) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.countryInfo];
    
    [self makeConstraint];
}


- (void)setDataWithModel:(YSQCountryDetail *)model {
    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.frame delegate:nil placeholderImage:nil];
    self.scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    self.scrollView.imageURLStringsGroup = model.photos;
//    self.scrollView.autoresizesSubviews = YES;
//    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
    if (model.photos.count == 1) {
        self.scrollView.autoScrollTimeInterval = 10000;
    }
    self.scrollView.autoScrollTimeInterval = 3.0;
    [self addSubview:self.scrollView];
    [self sendSubviewToBack:self.scrollView];
    self.cnCountry.text = model.cnname;
    self.enCountry.text = model.enname;
    self.des.text = model.entryCont;
    if (self.isCity) {
        [self.countryInfo setTitle:@"城市实用信息 >" forState:UIControlStateNormal];
    } else {
        [self.countryInfo setTitle:@"国家实用信息 >" forState:UIControlStateNormal];
    }
}

- (void)makeConstraint {
    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(-30);
    }];
    
    [self.countryInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    [self.enCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self.des.mas_top).offset(-10);
    }];
    
    [self.cnCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self.enCountry.mas_top).offset(-5);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);

    }];
}

- (void)goToCountryDesInfo {
    
}

@end
