//
//  YSQAuthorInfoCell.m
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQAuthorInfoCell.h"
#import "YSQKitsDetailModel.h"

@interface YSQAuthorInfoCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *des;

@end

@implementation YSQAuthorInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"info";
    YSQAuthorInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[self  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCell];
        [self makeConstraints];
    }
    return  self;
}

- (void)setDataWithModel:(YSQAuthorModel *)model {
    [self.icon setImageWithURL:[NSURL URLWithString:model.avatar] options:YYWebImageOptionProgressive];
    self.name.text = model.username;
    self.des.text = model.intro;
}

- (void)createCell {
    self.icon = [UIImageView new];
    self.icon.backgroundColor = YSQGray;
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds = YES;
    [self.contentView addSubview:self.icon];
    
    self.name = [UILabel new];
    self.name.font = YSQNormalFont;
    self.name.textColor = YSQSteel;
    [self.contentView addSubview:self.name];
    
    self.des = [UILabel new];
    self.des.font = YSQNormalFont;
    self.des.textColor = YSQGray;
    self.des.numberOfLines = 0;
    [self.contentView addSubview:self.des];
    
}

- (void)makeConstraints {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.and.height.equalTo(@40);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.centerY.equalTo(self.icon.mas_centerY);
    }];
    
    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.icon.mas_bottom).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
