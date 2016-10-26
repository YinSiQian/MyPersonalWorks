//
//  YSQMallGoodsCell.m
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQMallGoodsCell.h"
#import "YSQMallHotGoodsModel.h"

@interface YSQMallGoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *sales;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end


@implementation YSQMallGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 2;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithWhite:0.902 alpha:1.000].CGColor;
}

- (void)setDataWithModel:(YSQMallHotGoodsModel *)model {
    [self.icon setImageWithURL:[NSURL URLWithString:model.photo] options:1];
    self.title.text = model.title;
    self.sales.text = model.status;
    NSString *priceStr = [NSString stringWithFormat:@"%@元起",model.price];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:priceStr];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, priceStr.length - 2)];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, priceStr.length - 2)];
    self.price.attributedText = attri;

}

@end
