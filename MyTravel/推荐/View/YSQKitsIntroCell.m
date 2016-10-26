//
//  YSQKitsIntroCell.m
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQKitsIntroCell.h"

@implementation YSQKitsIntroCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"intro";
    YSQKitsIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[self  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCell];
    }
    return  self;
}

- (void)createCell {
    self.intro = [UILabel new];
    self.intro.numberOfLines = 0;
    self.intro.textColor = YSQGray;
    self.intro.font = YSQNormalFont;
    [self.contentView addSubview:self.intro];
    
    [self.intro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-10);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
