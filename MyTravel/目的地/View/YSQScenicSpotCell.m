//
//  YSQScenicSpotCell.m
//  MyTravel
//
//  Created by ysq on 16/6/27.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQScenicSpotCell.h"
#import "YSQCityMapModel.h"

@interface YSQScenicSpotCell ()

@property (nonatomic, strong) UIImageView *desImg;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) UILabel *distance;
@property (nonatomic, strong) UIImageView *stars;
@property (nonatomic, strong) UIButton *navigation;
@property (nonatomic, strong) UIView *backView;


@end

@implementation YSQScenicSpotCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        [self createSubviews];
        [self makeConstraints];
    }
    return self;
}

- (void)setDataWithModel:(YSQCityMapModel *)model {
    self.title.text = [model.cnname  isEqual: @""] ? model.enname : model.cnname;
    self.type.text = model.tags_name;
    [self.desImg setImageURL:[NSURL URLWithString:model.photo]];
    _backView.width = model.grade.integerValue / 10.0 * self.stars.width;
}

- (void)createSubviews {
    self.desImg = [UIImageView new];
    self.desImg.layer.cornerRadius = 4;
    self.desImg.layer.masksToBounds = YES;
    [self.contentView addSubview:self.desImg];
    
    self.title = [UILabel new];
    self.title.textColor = YSQBlack;
    self.title.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.title];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(110, 30, 65, 23)];
    _backView.backgroundColor = [UIColor clearColor];
    _backView.clipsToBounds = YES;
    [self.contentView addSubview:_backView];
    
    self.stars = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 23)];
    self.stars.clipsToBounds = YES;
    self.stars.image = [UIImage imageNamed:@"StarsForeground"];
    [_backView addSubview:self.stars];
    
    self.type = [UILabel new];
    self.type.textColor = YSQGray;
    self.type.font = YSQSamllFont;
    [self.contentView addSubview:self.type];
    
    self.distance = [UILabel new];
    self.distance.textColor = YSQGray;
    self.distance.font = YSQNormalFont;
    [self.contentView addSubview:self.distance];
    
    self.navigation = [UIButton new];
    [self.navigation setBackgroundImage:[UIImage imageNamed:@"way_40x40_"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.navigation];
    [self.navigation addTarget:self action:@selector(startNavigationToDestination) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)startNavigationToDestination {
    UICollectionView *collectionView = (UICollectionView *)self.superview;
    NSIndexPath *index = [collectionView indexPathForCell:self];
    if ([self.delegate respondsToSelector:@selector(wakeUpMAMapToNavigation:)]) {
        [self.delegate wakeUpMAMapToNavigation:index.item];
    }
}

- (void)makeConstraints {
    [self.desImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@90);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desImg);
        make.left.equalTo(self.desImg.mas_right).offset(10);
        make.right.equalTo(self.navigation.mas_left).offset(-10);
    }];
    
    [self.type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.desImg.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-12);
        make.right.equalTo(self.distance.mas_left).offset(-10);
    }];
    
    [self.distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-12);
    }];
    
    [self.navigation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self.distance.mas_top).offset(-12);
        make.top.equalTo(self).offset(12);
        make.width.equalTo(@40);
    }];


    
}

@end
