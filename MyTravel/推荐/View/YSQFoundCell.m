//
//  MTFoundCell.m
//  MyTravel
//
//  Created by ysq on 16/1/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQFoundCell.h"
#import "YSQNewDiscount.h"

@interface YSQFoundCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation YSQFoundCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    YSQFoundCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSQFoundCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setDataWithModel:(YSQNewDiscount *)model {
    [self.image setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionProgressive];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
