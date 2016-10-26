//
//  YSQMallDiscountHeaderCell.m
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQMallDiscountHeaderCell.h"

@interface YSQMallDiscountHeaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;


@property (weak, nonatomic) IBOutlet UIButton *picBtn;

@end

@implementation YSQMallDiscountHeaderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"YSQMallDiscountHeaderCell";
    YSQMallDiscountHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSQMallDiscountHeaderCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setData {
    self.sectionTitle.text = _topic[@"title"];
    [self.picBtn setBackgroundImageWithURL:[NSURL URLWithString:_topic[@"photo"]] forState:UIControlStateNormal options:1];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.picBtn.layer.cornerRadius = 4;
    self.picBtn.clipsToBounds = YES;
    // Initialization code
}

- (IBAction)clickAction:(id)sender {
    
}

- (void)setTopic:(NSDictionary *)topic {
    _topic = topic;
    [self setData];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
