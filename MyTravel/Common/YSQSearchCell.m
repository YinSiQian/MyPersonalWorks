//
//  YSQSearchCell.m
//  MyTravel
//
//  Created by ysq on 16/8/28.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQSearchCell.h"
#import "YSQSearchResultModel.h"


@interface YSQSearchCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImageView *timeImg;
@property (nonatomic, strong) UIImageView *comImg;

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *see_count;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *comments;

@property (nonatomic, strong) UIView *separatorLine;

@property (nonatomic, strong) UILabel *title;

@end

@implementation YSQSearchCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"search";
    YSQSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[YSQSearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
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

- (void)setDataWithModel:(YSQSearchResultModel *)model {
    self.title.text = model.title;
    [self.icon setImageWithURL:[NSURL URLWithString:model.avatar] options:YYWebImageOptionProgressive];
    self.see_count.text = [NSString stringWithFormat:@"%@人浏览过",model.views];
    self.name.text = model.username;
    self.comments.text = model.replys.stringValue;
    self.time.text = [NSString countTimeFromNow:model.lastpost.stringValue];
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
    
    self.title = [[UILabel alloc]init];
    
    self.title.font = [UIFont boldSystemFontOfSize:15];
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.numberOfLines = 0;
    [self.contentView addSubview:self.title];
    

    self.see_count = UILabel.new;
    self.see_count.textColor = [UIColor grayColor];
    self.see_count.font = YSQSamllFont;
    [self.contentView addSubview:self.see_count];
    
    self.time = UILabel.new;
    self.time.textColor = UIColor.grayColor;
    self.time.font = YSQSamllFont;
    [self.contentView addSubview:self.time];
    
    self.timeImg = [UIImageView new];
    self.timeImg.image = [UIImage imageNamed:@"time_icon"];
    [self.contentView addSubview:self.timeImg];
    
    
    self.comments = UILabel.new;
    self.comments.textColor = UIColor.grayColor;
    self.comments.font = YSQSamllFont;
    [self.contentView addSubview:self.comments];
    
    self.comImg = [UIImageView new];
    self.comImg.image = [UIImage imageNamed:@"comment_icon"];
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
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.name.mas_bottom).offset(10);

    }];
    
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.and.bottom.equalTo(self).offset(0);
        make.height.equalTo(@10);
    }];
    
    [self.see_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(65);
        make.bottom.equalTo(self.separatorLine.mas_top).offset(-15);
    }];
    
    [self.comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self.separatorLine.mas_top).offset(-15);
    }];
    
    [self.comImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.comments);
        make.right.equalTo(self.comments.mas_left).offset(-5);
    }];
    
    [self.timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.comments);
        make.right.equalTo(self.time.mas_left).offset(-5);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.comments);
        make.right.equalTo(self.comImg.mas_left).offset(-15);
    }];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
