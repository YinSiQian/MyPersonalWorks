//
//  YSQHotBBSCell.m
//  MyTravel
//
//  Created by ysq on 16/6/16.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotBBSCell.h"
#import "YSQHotBBSModel.h"

@interface YSQHotBBSCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UIImageView *rightImg;
@property (nonatomic, strong) UIImageView *middleImg;
@property (nonatomic, strong) UIImageView *timeImg;
@property (nonatomic, strong) UIImageView *comImg;

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) YYLabel *title;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *comments;

@property (nonatomic, strong) UIView *separatorLine;

@property (nonatomic, strong) UILabel *label;

@end

@implementation YSQHotBBSCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"hotBBS";
    YSQHotBBSCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[YSQHotBBSCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubviews];
        [self makeConstraints];
    }
    return self;
}

- (void)setDataWithModel:(YSQHotBBSModel *)model {
    //重置隐藏所有UIImageView 避免图片复用错位.
    self.leftImg.hidden = YES;
    self.middleImg.hidden = YES;
    self.rightImg.hidden = YES;

    self.name.text = model.author;
    [self.icon setImageWithURL:[NSURL URLWithString:model.avatar] options:YYWebImageOptionProgressive];
    self.address.text = model.forum;
    self.time.text = model.reply_time;
    self.comments.text = [NSString stringWithFormat:@"%@",model.reply_num];
    self.title.text = model.title;
    CGSize titleSize = [model.title sizeForFont:[UIFont boldSystemFontOfSize:15] size:CGSizeMake(WIDTH - 65 - 25, 40) mode:NSLineBreakByWordWrapping];
    self.title.height = titleSize.height + 2 ;
    if (model.is_hot.boolValue || model.is_best.boolValue) {
        
        NSAttributedString *attributed = [self getAttributedString:model.title isHot:model.is_hot.boolValue isbest:model.is_best.boolValue];
        self.title.attributedText = attributed;
    }
    
    if (model.bigpic_arr.count != 0 ) {
        self.leftImg.hidden = NO;
        [self.leftImg setImageWithURL:[NSURL URLWithString:model.bigpic_arr[0]] options:YYWebImageOptionProgressive];
        if (model.bigpic_arr.count == 1) {
             return;
        }
        self.middleImg.hidden = NO;
        if (model.bigpic_arr.count >= 2) {
            [self.middleImg setImageWithURL:[NSURL URLWithString:model.bigpic_arr[1]] options:YYWebImageOptionProgressive];
        }
        if (model.bigpic_arr.count == 2) {
            return;
        }
        self.rightImg.hidden = NO;
        if (model.bigpic_arr.count == 3) {
            [self.rightImg setImageWithURL:[NSURL URLWithString:model.bigpic_arr[2]] options:YYWebImageOptionProgressive];
        }
    }
}

- (NSString *)getStringByLength:(CGFloat)length originStr:(NSString *)astring {
    //计算每个字的平均宽度
    CGFloat characterWidth = length / astring.length;
    //计算固定的2行宽度下有多少个字
    NSInteger stringLength = 2 * (WIDTH - 65 - 25) / characterWidth;
    //截取字符串
    NSString *resultString = [astring substringToIndex:stringLength - 3];
    resultString = [NSString stringWithFormat:@"%@...  ",resultString];
    return resultString;
}

- (NSAttributedString *)getAttributedString:(NSString *)astring isHot:(BOOL)hot isbest:(BOOL)best{
    NSMutableAttributedString *attributed = [NSMutableAttributedString new];
    NSString *type = @"";
    if (hot) {
        type = @"热议";
    }
    if (best) {
        type = @"精华";
    }
    CGFloat titleLength = [astring widthForFont:[UIFont boldSystemFontOfSize:15]];
    NSMutableAttributedString *one;
    if (titleLength > 2 * ( WIDTH - 65 - 25 ) - 40) {
        NSString *handleString = [self getStringByLength:titleLength originStr:astring];
        one = [[NSMutableAttributedString alloc] initWithString:handleString];
    } else {
        one = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@    ",astring]];
    }
    one.font = [UIFont boldSystemFontOfSize:14];
    one.color = [UIColor blackColor];
    //生产带圆角以及背景颜色的富文本标签
    NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:type];
    two.color = [UIColor whiteColor];
    YYTextBorder *border = [YYTextBorder new];
    border.strokeColor = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
    border.cornerRadius = 3;
    if (hot) {
        border.fillColor =  [UIColor colorWithRed:1.000 green:0.720 blue:0.000 alpha:1.000];
    } else if (best) {
        border.fillColor =  [UIColor colorWithRed:1.000 green:0.259 blue:0.000 alpha:1.000];
    }
    border.insets = UIEdgeInsetsMake(0, -4, 0, -4);
    two.textBackgroundBorder = border;
    
    [attributed appendAttributedString:one];
    [attributed appendAttributedString:two];
    return attributed;
}

- (void)createSubviews {
    self.icon = [UIImageView new];
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds = YES;
    [self.contentView addSubview:self.icon];
    
    self.name = UILabel.new;
    self.name.textColor = UIColor.grayColor;
    self.name.font = YSQSamllFont;
    [self.contentView addSubview:self.name];
    
    self.title = [[YYLabel alloc]initWithFrame:CGRectMake(65, 34, WIDTH - 65 - 25, 0)];

    self.title.font = [UIFont boldSystemFontOfSize:15];
    self.title.textAlignment = NSTextAlignmentLeft;
    self.top = 0;
    self.title.numberOfLines = 2;
    [self.contentView addSubview:self.title];
    
    self.leftImg = [UIImageView new];
    self.leftImg.layer.cornerRadius = 4;
    self.leftImg.layer.masksToBounds = YES;
    [self.contentView addSubview:self.leftImg];
    
    self.rightImg = [UIImageView new];
    self.rightImg.layer.cornerRadius = 4;
    self.rightImg.layer.masksToBounds = YES;
    [self.contentView addSubview:self.rightImg];
    
    self.middleImg = [UIImageView new];
    self.middleImg.layer.cornerRadius = 4;
    self.middleImg.layer.masksToBounds = YES;
    [self.contentView addSubview:self.middleImg];
    
    self.leftImg.hidden = YES;
    self.middleImg.hidden = YES;
    self.rightImg.hidden = YES;

    
    self.address = UILabel.new;
    self.address.textColor = YSQGreenColor(1);
    self.address.font = YSQSamllFont;
    [self.contentView addSubview:self.address];
    
    self.time = UILabel.new;
    self.time.textColor = UIColor.grayColor;
    self.time.font = YSQSamllFont;
    [self.contentView addSubview:self.time];
    
    self.timeImg = [UIImageView new];
    self.timeImg.image = [UIImage imageNamed:@"time_icon"];
    [self.contentView addSubview:self.timeImg];
    
    self.comments = UILabel.new;
    self.comments.textColor = UIColor.grayColor;
    self.comments.font = YSQSamllFont;
    [self.contentView addSubview:self.comments];
    
    self.comImg = [UIImageView new];
    self.comImg.image = [UIImage imageNamed:@"comment_icon"];
    [self.contentView addSubview:self.comImg];
    
    self.separatorLine = [UIView new];
    self.separatorLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.contentView addSubview:self.separatorLine];
}

- (void)makeConstraints {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self).offset(15);
        make.height.and.width.equalTo(@40);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.top.equalTo(self).offset(10);
    }];
    
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(65);
        make.top.equalTo(self.title.mas_bottom).offset(12);
        make.right.equalTo(self.middleImg.mas_left).offset(-10);
        make.height.equalTo(@80);
        make.width.equalTo(@[self.middleImg,self.rightImg]);
    }];
    
    [self.middleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImg.mas_right).offset(10);
        make.top.equalTo(self.title.mas_bottom).offset(12);
        make.right.equalTo(self.rightImg.mas_left).offset(-10);
        make.height.equalTo(@80);
        make.width.equalTo(@[self.middleImg,self.rightImg]);
    }];
    
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleImg.mas_right).offset(10);
        make.top.equalTo(self.title.mas_bottom).offset(12);
        make.right.equalTo(self).offset(-20);
        make.height.equalTo(@80);
        make.width.equalTo(@[self.middleImg,self.rightImg]);
    }];
        
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.and.bottom.equalTo(self).offset(0);
        make.height.equalTo(@10);
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(65);
        make.bottom.equalTo(self.separatorLine.mas_top).offset(-15);
    
    }];
    
    [self.comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self.separatorLine.mas_top).offset(-15);
    }];
    
    [self.comImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.comments);
        make.right.equalTo(self.comments.mas_left).offset(-5);
    }];
    
    [self.timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.comments);
        make.right.equalTo(self.time.mas_left).offset(-5);
    }];

    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.comImg.mas_left).offset(-15);
        make.bottom.equalTo(self.separatorLine.mas_top).offset(-15);
//        make.width.mas_greaterThanOrEqualTo(self.address).with.priority(253);
    }];
 }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
