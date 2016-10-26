//
//  YSQAddressCell.m
//  MyTravel
//
//  Created by ysq on 16/5/24.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQAddressCell.h"
#import "YSQAddressModel.h"

@interface YSQAddressCell ()

@property (nonatomic, strong) UILabel *cnname;
@property (nonatomic, strong) UILabel *enname;

@end

@implementation YSQAddressCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"address";
    YSQAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
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
        self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    }
    return  self;
}

- (void)setDataWithModel:(YSQAddressModel *)model {
    self.cnname.text = model.cnname;
    self.enname.text = model.enname;
}

- (void)createCell {
    self.cnname = [UILabel new];
    self.cnname.textColor = YSQSteel;
    self.cnname.font = YSQNormalFont;
    [self.contentView addSubview:self.cnname];
    
    self.enname = [UILabel new];
    self.enname.textColor = YSQGray;
    self.enname.font = YSQLittleFont;
    [self.contentView addSubview:self.enname];
}

- (void)makeConstraints {
    [self.cnname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(10);
    }];
    
    [self.enname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-10);
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
