//
//  YSQFreedomCell.m
//  MyTravel
//
//  Created by ysq on 16/2/5.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQFreedomCell.h"
#import "YSQNewDiscount.h"

@interface YSQFreedomCell ()
@property (nonatomic, retain) UIImageView *icon;
@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *discount;
@property (nonatomic, retain) UILabel *currentPrice;
@property (nonatomic, strong) UIView *line;
@end

@implementation YSQFreedomCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"freedom";
    YSQFreedomCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[self  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return  self;
}

- (void)createUI {
    self.icon = [UIImageView new];
    self.icon.backgroundColor = YSQGray;
    [self.contentView addSubview:self.icon];
    
    self.name = [UILabel new];
    self.name.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
    self.name.font = [UIFont systemFontOfSize:14];
    self.name.numberOfLines = 2;
    [self.contentView addSubview:self.name];
    
    self.discount = [UILabel new];
    self.discount.textColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    self.discount.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.discount];
    
    self.currentPrice = [UILabel new];
    self.currentPrice.textColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000];
    self.currentPrice.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.currentPrice];
    
    self.line = [UIView new];
    self.line.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.contentView addSubview:self.line];
    
    [self makeConstraint];
}

- (void)makeConstraint {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@100);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.top.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-10);
    }];
    
    [self.discount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    [self.currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-5);
        make.right.equalTo(self).offset(-10);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(self).offset(0);
        make.height.equalTo(@.5);
    }];

}

- (void)setDataWithModel:(YSQNewDiscount *)model {
    NSString *price =  [NSString stringWithFormat:@"%@元起",[YSQHelp GetPriceInStr:model.price]];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:price];
    [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(price.length -2, 2)];
    [self.icon setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionSetImageWithFadeAnimation];
    self.name.text = model.title;
    self.discount.text = model.priceoff;
    if ([price hasPrefix:@"Free"]) {
        self.currentPrice.text = @"Free";
    } else {
        self.currentPrice.attributedText =  attribute;
    }
    
}



@end
