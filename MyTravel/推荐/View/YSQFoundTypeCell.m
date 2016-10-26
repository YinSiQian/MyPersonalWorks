//
//  MTFoundTypeCell.m
//  MyTravel
//
//  Created by ysq on 16/1/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQFoundTypeCell.h"
#import "YSQSubjectModel.h"
#import "YSQHotCity.h"

@interface YSQFoundTypeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UILabel *leftCnname;
@property (weak, nonatomic) IBOutlet UILabel *leftEnname;
@property (weak, nonatomic) IBOutlet UILabel *rightCnname;
@property (weak, nonatomic) IBOutlet UILabel *rightEname;

@property (nonatomic, copy) NSString *leftURL;
@property (nonatomic, copy) NSString *rightURL;

@property (nonatomic, strong) YSQHotCity *leftModel;
@property (nonatomic, strong) YSQHotCity *rightModel;

@end

@implementation YSQFoundTypeCell



+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    YSQFoundTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSQFoundTypeCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setDataWithArray:(NSArray *)array {
    YSQSubjectModel *left = array[1];
    YSQSubjectModel *right = array[2];
    self.leftURL = left.url;
    self.rightURL = right.url;
    [self.leftImage sd_setImageWithURL:[NSURL URLWithString:left.photo]];
    [self.rightImage sd_setImageWithURL:[NSURL URLWithString:right.photo]];
}

- (void)setDataWithLeftModel:(YSQHotCity *)model {
    self.leftModel = model;
    self.leftCnname.text = model.cnname;
    self.leftEnname.text = model.enname;
    [self.leftImage setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionSetImageWithFadeAnimation];
}

- (void)setDataWithRightModel:(YSQHotCity *)model {
    self.rightModel = model;
    self.rightCnname.text = model.cnname;
    self.rightEname.text = model.enname;
    [self.rightImage setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionSetImageWithFadeAnimation];
}

- (IBAction)leftBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(showDetailWithURL:)]) {
        [self.delegate showDetailWithURL:self.leftURL];
    }
    if ([self.hotDelegate respondsToSelector:@selector(showCityDetailWithModel:)]) {
        [self.hotDelegate showCityDetailWithModel:self.leftModel];
    }
  
}

- (IBAction)rightBtn:(id)sender {
    
    if ([self.hotDelegate respondsToSelector:@selector(showCityDetailWithModel:)]) {
        [self.hotDelegate showCityDetailWithModel:self.rightModel];
    }
    if ([self.delegate respondsToSelector:@selector(showDetailWithURL:)]) {
        [self.delegate showDetailWithURL:self.rightURL];
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
