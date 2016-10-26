//
//  YSQHotAreaCell.m
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotAreaCell.h"
#import "YSQHotAreaModel.h"
#import "YSQMallListModel.h"

@interface YSQHotAreaCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIButton *place1;
@property (weak, nonatomic) IBOutlet UIButton *place2;
@property (weak, nonatomic) IBOutlet UIButton *place3;
@property (weak, nonatomic) IBOutlet UIButton *place4;

@property (weak, nonatomic) IBOutlet UILabel *place1Title;

@property (weak, nonatomic) IBOutlet UILabel *place2Title;

@property (weak, nonatomic) IBOutlet UILabel *place3Title;

@property (weak, nonatomic) IBOutlet UILabel *place4Title;

@property (weak, nonatomic) IBOutlet UIView *discountView1;



@property (weak, nonatomic) IBOutlet UIView *discountV2;


@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UILabel *v1Title;
@property (weak, nonatomic) IBOutlet UILabel *v1Sales;
@property (weak, nonatomic) IBOutlet UILabel *v1Price;

@property (weak, nonatomic) IBOutlet UIImageView *v2Image;
@property (weak, nonatomic) IBOutlet UILabel *v2Title;
@property (weak, nonatomic) IBOutlet UILabel *v2Sales;
@property (weak, nonatomic) IBOutlet UILabel *v2Price;

@property (weak, nonatomic) IBOutlet UIButton *topicBtn;

@property (nonatomic, strong) YSQHotAreaModel *HotModel;

@end


@implementation YSQHotAreaCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"hotArea";
    YSQHotAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSQHotAreaCell" owner:nil options:nil] lastObject];
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    [self.place1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.place4.mas_width);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.place1.layer.cornerRadius = 4;
    self.place2.layer.cornerRadius = 4;
    self.place3.layer.cornerRadius = 4;
    self.place4.layer.cornerRadius = 4;
    self.place1.clipsToBounds = YES;
    self.place2.clipsToBounds = YES;
    self.place3.clipsToBounds = YES;
    self.place4.clipsToBounds = YES;

    self.discountView1.layer.cornerRadius = 4;
    self.discountView1.layer.borderColor = [UIColor colorWithWhite:0.902 alpha:1.000].CGColor;
    self.discountView1.layer.borderWidth = 1;
    self.discountView1.clipsToBounds = YES;
    self.discountV2.layer.cornerRadius = 4;
    self.discountV2.clipsToBounds = YES;
    self.discountV2.layer.borderColor = [UIColor colorWithWhite:0.902 alpha:1.000].CGColor;
    self.discountV2.layer.borderWidth = 1;
    // Initialization code
}

- (void)setDataModel:(YSQHotAreaModel *)model {
    _HotModel = model;
    NSArray *btnArr = @[self.place1,self.place2,self.place3,self.place4];
    NSArray *titleArr = @[self.place1Title,self.place2Title,self.place3Title,self.place4Title];
    self.title.text = [YSQHelp matchString:model.type];
    for (int index = 0; index < btnArr.count; index++) {
        YSQPlaceModel *placeModel = model.place[index];
        UIButton *btn = btnArr[index];
        UILabel *label = titleArr[index];
        label.text = placeModel.name;
        [btn setBackgroundImageWithURL:[NSURL URLWithString:placeModel.photo] forState:UIControlStateNormal options:YYWebImageOptionProgressive];
    }
    [self.topicBtn setTitle:[NSString stringWithFormat:@"查看%@专题",self.title.text] forState:UIControlStateNormal];
    
    YSQMallListModel *model1 = model.list.firstObject;
    self.v1Title.text = model1.title;
    NSString *priceStr = [NSString stringWithFormat:@"%@元起",model1.price];
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc]initWithString:priceStr];
    [attri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, priceStr.length - 2)];
    [attri1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, priceStr.length - 2)];
    self.v1Price.attributedText = attri1;
    self.v1Sales.text = model1.sold;
    [self.image1 setImageWithURL:[NSURL URLWithString:model1.photo] options:YYWebImageOptionProgressive];
    
    YSQMallListModel *model2 = model.list.lastObject;
    self.v2Title.text = model2.title;
    NSString *priceStr2 = [NSString stringWithFormat:@"%@元起",model2.price];
    NSMutableAttributedString *attri2 = [[NSMutableAttributedString alloc]initWithString:priceStr2];
    [attri2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, priceStr2.length - 2)];
    [attri2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, priceStr2.length - 2)];
    self.v2Price.attributedText = attri2;
    self.v2Sales.text = model2.sold;
    [self.v2Image setImageWithURL:[NSURL URLWithString:model2.photo] options:YYWebImageOptionProgressive];
}

- (IBAction)place1:(UIButton *)sender {
    YSQPlaceModel *placeModel = _HotModel.place[0];
    [self responseFunction:placeModel.ID];
}

- (IBAction)place2:(UIButton *)sender {
    YSQPlaceModel *placeModel = _HotModel.place[1];
    [self responseFunction:placeModel.ID];

}

- (IBAction)place3:(UIButton *)sender {
    YSQPlaceModel *placeModel = _HotModel.place[2];
    [self responseFunction:placeModel.ID];

}

- (IBAction)place4:(id)sender {
    YSQPlaceModel *placeModel = _HotModel.place[3];
    [self responseFunction:placeModel.ID];

}

- (IBAction)v1Action:(id)sender {
    YSQMallListModel *model = _HotModel.list.firstObject;
    if ([self.delegate respondsToSelector:@selector(seeDiscountDetail:)]) {
        [self.delegate seeDiscountDetail:model.ID];
    }
}

- (IBAction)v2Action:(id)sender {
    YSQMallListModel *model = _HotModel.list.lastObject;
    if ([self.delegate respondsToSelector:@selector(seeDiscountDetail:)]) {
        [self.delegate seeDiscountDetail:model.ID];
    }

}



- (void)responseFunction:(NSString *)ID {
    if ([self.delegate respondsToSelector:@selector(seeHotCountry:)]) {
        [self.delegate seeHotCountry:ID];
    }
}

- (IBAction)seeTopic:(id)sender {
    if ([self.delegate respondsToSelector:@selector(seeAreaTopic:)]) {
        [self.delegate seeAreaTopic:_HotModel.type];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
