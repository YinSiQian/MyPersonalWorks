//
//  YSQNewInfoCell.m
//  MyTravel
//
//  Created by ysq on 16/4/29.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQNewInfoCell.h"
#import "YSQForumDetailModel.h"
#import "YSQTopFlagView.h"

@interface YSQNewInfoCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *comments;
@property (nonatomic, strong) YSQTopFlagView *flag;

@end

@implementation YSQNewInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"newinfo";
    YSQNewInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[self  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCell];
    }
    return  self;
}

- (void)setDataWithModel:(YSQEntryModel *)model {
    [self.icon setImageWithURL:[NSURL URLWithString:model.avatar] options:YYWebImageOptionProgressive];
    self.name.text = model.username;
    self.content.text = model.title;
    self.comments.text = [NSString stringWithFormat:@"回复: %@",model.replys];
    self.time.text = [NSString formatterTime:model.publish_time];
    if (model.is_top.boolValue) {
//        self.flag.hidden = NO;
    }
}

- (void)createCell {
    
    self.flag = [[YSQTopFlagView alloc]initWithFlag:@"置顶"];
    self.flag.hidden = YES;
    [self.contentView addSubview:self.flag];
    
    self.icon = [UIImageView new];
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds = YES;
    [self.contentView addSubview:self.icon];
   
    self.name = [UILabel new];
    self.name.textColor = YSQSteel;
    self.name.font = YSQNormalFont;
    [self.contentView addSubview:self.name];
    
    self.content = [UILabel new];
    self.content.textColor = YSQSteel;
    self.content.font = YSQSamllFont;
    self.content.numberOfLines = 2;
    [self.contentView addSubview:self.content];
    
    self.time = [UILabel new];
    self.time.textColor = YSQGray;
    self.time.font = YSQLittleFont;
    [self.contentView addSubview:self.time];
    
    self.comments = [UILabel new];
    self.comments.textColor = [UIColor colorWithRed:0.000 green:0.776 blue:0.000 alpha:1.000];
    self.comments.font = YSQLittleFont;
    [self.contentView addSubview:self.comments];

    [self makeConstraints];
}

- (void)makeConstraints {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.and.height.equalTo(@40);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(5);
        make.top.equalTo(self).offset(12);
    }];
    
    [self.flag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(12);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.name);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.name.mas_bottom).offset(10);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.name);
        make.bottom.equalTo(self).offset(-10);
    }];

    [self.comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
    }];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
