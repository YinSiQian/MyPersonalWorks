//
//  YSQMallDiscountCell.m
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQMallDiscountCell.h"
#import "YSQMallListModel.h"


@interface YSQMallDiscountCell ()

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *sales;
@end

@implementation YSQMallDiscountCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"MallDiscountCell";
    YSQMallDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSQMallDiscountCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.cornerRadius = 4;
    self.backView.layer.borderColor = [UIColor colorWithWhite:0.902 alpha:1.000].CGColor;
    self.backView.layer.borderWidth = 1;
    self.backView.clipsToBounds = YES;
    CGFloat width = (WIDTH - 15 - 15 - 3 * 10) / 4;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
    }];
}

- (void)setDataWithModel:(YSQMallListModel *)model {
    self.title.text = model.title;
    self.sales.text = model.sold;
    NSString *priceStr = [NSString stringWithFormat:@"%@元起",model.price];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:priceStr];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, priceStr.length - 2)];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, priceStr.length - 2)];
    self.price.attributedText = attri;
    [self.icon setImageWithURL:[NSURL URLWithString:model.photo] options:1];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
