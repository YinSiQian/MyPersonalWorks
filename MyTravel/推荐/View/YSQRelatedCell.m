//
//  YSQRelatedCell.m
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQRelatedCell.h"
#import "YSQKitsDetailModel.h"

@interface YSQRelatedCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *distinct;
@property (nonatomic, strong) UILabel *size;
@property (nonatomic, strong) UILabel *updateTime;


@end

@implementation YSQRelatedCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"related";
    YSQRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
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

- (void)setDataWithModel:(YSQRelateModel *)model {
    NSNumber *file = model.mobile[@"size"];
    CGFloat fileSize = file.floatValue / 1024.0 /1024.0 ;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/670_446.jpg?%@",model.cover,model.cover_updatetime]];
    [self.icon setImageWithURL:url options:YYWebImageOptionProgressive];
    self.size.text = [NSString stringWithFormat:@"大小:  %.1f M",fileSize];
    self.updateTime.text = [NSString stringWithFormat:@"更新时间: %@",[NSString formatterTime:[NSNumber numberWithInteger:model.update_time.integerValue]]];
    self.name.text = model.cnname;
    self.distinct.text = [NSString stringWithFormat:@"%@/%@",model.category_title,model.country_name_cn];    
}

- (void)createCell {
    self.icon = [UIImageView new];
    self.icon.backgroundColor = YSQGray;
    [self.contentView addSubview:self.icon];
    
    self.name = [UILabel new];
    self.name.font = YSQNormalFont;
    self.name.textColor = YSQSteel;
    [self.contentView addSubview:self.name];
    
    self.distinct = [UILabel new];
    self.distinct.font = YSQSamllFont;
    self.distinct.textColor = YSQGray;
    [self.contentView addSubview:self.distinct];
    
    self.size = [UILabel new];
    self.size.font = YSQSamllFont;
    self.size.textColor = YSQGray;
    [self.contentView addSubview:self.size];
    
    self.updateTime = [UILabel new];
    self.updateTime.font = YSQSamllFont;
    self.updateTime.textColor = YSQGray;
    [self.contentView addSubview:self.updateTime];

}

- (void)makeConstraints {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@60);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.top.equalTo(self).offset(12);
    }];
    
    [self.updateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-12);
        make.left.equalTo(self.icon.mas_right).offset(10);
    }];
    
    [self.size mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.bottom.equalTo(self.updateTime.mas_top).offset(-5);
    }];
    
    [self.distinct mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.bottom.equalTo(self.size.mas_top).offset(-5);
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
