//
//  MTDiscountCell.m
//  MyTravel
//
//  Created by ysq on 16/1/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQDiscountCell.h"
#import "YSQDiscountModel.h"
#import "YSQNewDiscount.h"
@interface YSQDiscountCell ()

@property (weak, nonatomic) IBOutlet UIImageView *left_image;

@property (weak, nonatomic) IBOutlet UILabel *left_title;
@property (weak, nonatomic) IBOutlet UILabel *left_discount;
@property (weak, nonatomic) IBOutlet UILabel *left_price;
@property (weak, nonatomic) IBOutlet UIImageView *right_image;
@property (weak, nonatomic) IBOutlet UILabel *right_title;
@property (weak, nonatomic) IBOutlet UILabel *right_discount;
@property (weak, nonatomic) IBOutlet UILabel *right_price;

@property (nonatomic, strong) NSNumber *left_ID;
@property (nonatomic, strong) NSNumber *right_ID;
@end


@implementation YSQDiscountCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    YSQDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSQDiscountCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setLocalDataWithLeftModel:(YSQNewDiscount *)model {
    self.left_ID = model.ID;
    [self.left_image setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionSetImageWithFadeAnimation];
    self.left_discount.text = model.priceoff;
    self.left_title.text = model.title;
    self.left_price.text = [YSQHelp GetPriceInStr:model.price];
}

- (void)setLocalDataWithRightModel:(YSQNewDiscount *)model {
    self.right_ID = model.ID;
    [self.right_image setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionSetImageWithFadeAnimation];
    self.right_discount.text = model.priceoff;
    self.right_title.text = model.title;
    self.right_price.text = [YSQHelp GetPriceInStr:model.price];
}

- (void)setDataWithLeftModel:(YSQDiscountModel *)model {
    self.left_ID = model.ID;
    [self.left_image setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionSetImageWithFadeAnimation];
    self.left_title.text = model.title;
    self.left_discount.text = model.priceoff;
    self.left_price.text = [YSQHelp GetPriceInStr:model.price];
}

- (void)setDataWithRightModel:(YSQDiscountModel *)model {
    self.right_ID = model.ID;
    [self.right_image setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionSetImageWithFadeAnimation];
    self.right_title.text = model.title;
    self.right_discount.text = model.priceoff;
    self.right_price.text = [YSQHelp GetPriceInStr:model.price];
}

- (IBAction)leftSender:(id)sender {
    if ([self.delegate respondsToSelector:@selector(showDiscountDetailWithID:)]) {
        [self.delegate showDiscountDetailWithID:self.left_ID];
    }
}

- (IBAction)rightSender:(id)sender {
    if ([self.delegate respondsToSelector:@selector(showDiscountDetailWithID:)]) {
        [self.delegate showDiscountDetailWithID:self.right_ID];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
