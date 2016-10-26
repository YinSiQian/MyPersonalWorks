//
//  YSQGreatestChooseCell.m
//  MyTravel
//
//  Created by ysq on 16/3/2.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQGreatestChooseCell.h"
#import "YSQGreatestSelectModel.h"

@interface YSQGreatestChooseCell ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *travelName;
@property (nonatomic, strong) UILabel *travelCount;

@end

@implementation YSQGreatestChooseCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds = YES;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"choose";
    YSQGreatestChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[self  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return  self;
}

- (void)setDataWithModel:(YSQGreatestSelectModel *)model {
    [self.image setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionIgnoreAnimatedImage];
    self.title.text = model.title;
    [self.icon setImageWithURL:[NSURL URLWithString:model.avatar] options:YYWebImageOptionIgnoreAnimatedImage];
    self.name.text = model.username;
    self.travelCount.text = model.count;
    
    CGSize size = [NSString sizeWithText:model.count font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(WIDTH, HEIGHT)];
    self.backView.width = size.width > self.travelName.width ? size.width + 6 : self.travelName.width + 6;
    self.backView.height = size.height + self.travelName.height + 8;
    
}


- (void)createUI {
    self.image = [UIImageView new];
    [self.contentView addSubview:self.image];
    
    self.icon = [UIImageView new];
    [self.contentView addSubview:self.icon];
    
    self.backView = [UIView new];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.7;
    [self.image addSubview:self.backView];
    
    self.title = [UILabel new];
    self.title.font = [UIFont systemFontOfSize:14];
    self.title.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.title];
    
    self.name = [UILabel new];
    self.name.font = [UIFont systemFontOfSize:14];
    self.name.textColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    [self.contentView addSubview:self.name];
    
    self.travelName = [UILabel new];
    self.travelName.font = [UIFont systemFontOfSize:14];
    self.travelName.textColor = [UIColor whiteColor];
    self.travelName.text = @"旅行地";
    self.travelName.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.travelName];
    
    self.travelCount = [UILabel new];
    self.travelCount.font = [UIFont systemFontOfSize:16];
    self.travelCount.textAlignment = NSTextAlignmentCenter;
    self.travelCount.textColor = [UIColor whiteColor];
    [self.backView addSubview:self.travelCount];
    
    [self bringSubviewToFront:self.backView];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.equalTo(@180);
    }];
    
    [self.travelCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(2);
        make.right.equalTo(self.backView.mas_right).offset(-2);
        make.top.equalTo(self.backView.mas_top).offset(2);
    }];
    
    [self.travelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(2);
        make.right.equalTo(self.backView.mas_right).offset(-2);
        make.top.equalTo(self.travelCount.mas_bottom).offset(2);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.and.height.equalTo(@40);
        make.top.equalTo(self.image.mas_bottom).offset(-20);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.image.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_right).offset(5);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.icon.mas_bottom).offset(10);
    }];
}

@end
