//
//  MTHotNotesCell.m
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotNotesCell.h"
#import "YSQHotNotesModel.h"

@interface YSQHotNotesCell ()

@property (strong, nonatomic)  UILabel *name;
@property (strong, nonatomic)  UILabel *see_count;
@property (strong, nonatomic)  UILabel *reply_count;
@property (strong, nonatomic) UILabel *see;
@property (strong, nonatomic) UILabel *reply;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIView *line;

@end

@implementation YSQHotNotesCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCell];
        [self setConstraint];
    }
    return self;
}

- (void)createCell {
    self.name = [UILabel new];
    self.name.font = [UIFont systemFontOfSize:10];
    self.name.textColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    [self.contentView addSubview:self.name];
    
    self.title = [UILabel new];
    self.title.font = [UIFont systemFontOfSize:12];
    self.title.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    self.title.numberOfLines = 2;
    [self.contentView addSubview:self.title];
    
    self.see = [UILabel new];
    self.see.text = @"观看";
    self.see.font = [UIFont systemFontOfSize:10];
    self.see.textColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    [self.contentView addSubview:self.see];
    
    self.icon = [UIImageView new];
    self.icon.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.icon];
    
    
    self.reply = [UILabel new];
    self.reply.font = [UIFont systemFontOfSize:10];
    self.reply.textColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    self.reply.text = @"回复";
    [self.contentView addSubview:self.reply];
    
    self.reply_count = [UILabel new];
    self.reply_count.font = [UIFont systemFontOfSize:10];
    self.reply_count.textColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    [self.contentView addSubview:self.reply_count];
    
    self.see_count = [UILabel new];
    self.see_count.font = [UIFont systemFontOfSize:10];
    self.see_count.textColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    [self.contentView addSubview:self.see_count];
    
    self.line = [UIView new];
    self.line.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.contentView addSubview:self.line];
}

- (void)setConstraint {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@120);
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.top.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-10);
    }];
    
    [self.see mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    [self.see_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.see.mas_right).offset(2);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    [self.reply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.see_count.mas_right).offset(20);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    [self.reply_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reply.mas_right).offset(2);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.bottom.equalTo(self.see.mas_top).offset(-10);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.equalTo(@1);
    }];
}

- (void)setDataWithModel:(YSQHotNotesModel *)model {
    [self.icon setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionSetImageWithFadeAnimation];
    self.title.text = model.title;
    self.name.text = model.username;
    self.see_count.text = [NSString stringWithFormat:@"%@",model.views];
    self.reply_count.text = model.replys;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
