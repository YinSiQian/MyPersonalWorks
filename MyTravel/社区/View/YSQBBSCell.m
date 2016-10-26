//
//  YSQBBSCell.m
//  MyTravel
//
//  Created by ysq on 16/6/17.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQBBSCell.h"
#import "YSQGroupModel.h"

@interface YSQBBSCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *des;
@property (nonatomic, strong) UILabel *counts;

@end

@implementation YSQBBSCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"bbscell";
    YSQBBSCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[self  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubviews];
        [self makeConstraints];
    }
    return  self;
}

- (void)setDataWithModel:(YSQGroupModel *)model {
    [self.icon setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionProgressive];
    self.title.text = model.name;
    self.des.text = model.Description;
    self.counts.text = [NSString stringWithFormat:@"%@个帖子",model.total_threads];
}


- (void)createSubviews {
    self.icon = [UIImageView new];
    self.icon.layer.cornerRadius = 2;
    self.icon.layer.masksToBounds = YES;
    [self.contentView addSubview:self.icon];
    
    self.title = [UILabel new];
    self.title.textColor = YSQBlack;
    self.title.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:self.title];
    
    self.counts = [UILabel new];
    self.counts.textColor = YSQGray;
    self.counts.font = YSQSamllFont;
    [self.contentView addSubview:self.counts];
    
    self.des = [UILabel new];
    self.des.textColor = YSQGray;
    self.des.font = YSQSamllFont;
    [self.contentView addSubview:self.des];
}

- (void)makeConstraints {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-15);
        make.width.equalTo(@60);
    }];
    
    [self.counts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(20);
        make.width.mas_greaterThanOrEqualTo(self.title).with.priority(253);
//        make.left.mas_greaterThanOrEqualTo(self.title.mas_right).with.priority(751);
    
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.top.equalTo(self).offset(17);
        make.right.equalTo(self.counts.mas_left).offset(-5);
//        make.width.equalTo(self.counts.mas_left).with.priority(750);
    }];
    
    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-17);
        make.right.equalTo(self).offset(-10);
    }];
    



    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
