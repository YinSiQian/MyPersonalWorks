//
//  YSQHotBBSOtherCell.m
//  MyTravel
//
//  Created by ysq on 16/6/18.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotBBSOtherCell.h"
#import "YSQHotBBSModel.h"

@interface YSQHotBBSOtherCell ()

@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UIImageView *timeImg;
@property (nonatomic, strong) UIImageView *comImg;

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *comments;

@property (nonatomic, strong) UIView *separatorLine;

@end

@implementation YSQHotBBSOtherCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"otherBBS";
    YSQHotBBSOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[YSQHotBBSOtherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubviews];
        [self makeConstraints];
    }
    return self;
}

- (void)setDataWithModel:(YSQHotBBSModel *)model {
    self.name.text = model.author;
    [self.icon setImageWithURL:[NSURL URLWithString:model.avatar] options:YYWebImageOptionProgressive];
    self.address.text = model.forum;
    self.time.text = model.reply_time;
    self.comments.text = [NSString stringWithFormat:@"%@",model.reply_num];
    self.title.text = model.title;
}


- (void)createSubviews {
    self.icon = [UIImageView new];
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds = YES;
    [self.contentView addSubview:self.icon];
    
    self.name = UILabel.new;
    self.name.textColor = UIColor.grayColor;
    self.name.font = YSQSamllFont;
    [self.contentView addSubview:self.name];
    
    self.title = UILabel.new;
    self.title.textColor = UIColor.blackColor;
    self.title.font = [UIFont boldSystemFontOfSize:14];
    self.title.numberOfLines = 2;
    [self.contentView addSubview:self.title];
    
    self.address = UILabel.new;
    self.address.textColor = YSQGreenColor(1);
    self.address.font = YSQSamllFont;
    [self.contentView addSubview:self.address];
    
    self.time = UILabel.new;
    self.time.textColor = UIColor.grayColor;
    self.time.font = YSQSamllFont;
    [self.contentView addSubview:self.time];
    
    self.comments = UILabel.new;
    self.comments.textColor = UIColor.grayColor;
    self.comments.font = YSQSamllFont;
    [self.contentView addSubview:self.comments];
    
    self.comImg = [UIImageView new];
    self.comImg.image = [UIImage imageNamed:@"comment_img"];
    [self.contentView addSubview:self.comImg];
    
    self.separatorLine = [UIView new];
    self.separatorLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.contentView addSubview:self.separatorLine];
}

- (void)makeConstraints {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self).offset(15);
        make.height.and.width.equalTo(@40);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.top.equalTo(self).offset(10);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.name.mas_leading);
        make.top.equalTo(self.name.mas_bottom).offset(12);
        make.right.equalTo(self).offset(-25);
    }];
    
    
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.and.bottom.equalTo(self).offset(0);
        make.height.equalTo(@10);
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(65);
        make.bottom.equalTo(self.separatorLine.mas_top).offset(-15);
    }];
    
    [self.comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self.separatorLine.mas_top).offset(-15);
    }];
    
    [self.comImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.comments.mas_left).offset(-5);
        make.bottom.equalTo(self.separatorLine.mas_top).offset(-12);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.comImg.mas_left).offset(-15);
        make.bottom.equalTo(self.separatorLine.mas_top).offset(-15);
    }];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
