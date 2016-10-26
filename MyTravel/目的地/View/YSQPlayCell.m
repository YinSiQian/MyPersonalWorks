//
//  YSQPlayCell.m
//  MyTravel
//
//  Created by ysq on 16/3/2.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQPlayCell.h"
#import "YSQPlayDiscountModel.h"
#import "YSQPlayModel.h"

@interface YSQPlayCell()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *count;
@property (nonatomic, strong) UILabel *want;
@property (nonatomic, strong) UIImageView *stars_count_light;
@property (nonatomic, strong) UIImageView *stars_count_gray;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *love;

@end


@implementation YSQPlayCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"play";
    YSQPlayCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[self  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        [self createUI];
    }
    return  self;
}

//- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect);
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.902 alpha:1.000].CGColor);
//    CGContextStrokeRect(context, CGRectMake(10, rect.size.height, rect.size.width - 10, .5));
//}

- (void)setDataWithModel:(YSQPlayModel *)model {
    CGFloat width =  self.stars_count_light.width * model.gradescores.floatValue / 10.0;
    self.backView.width = width;
    self.count.text = model.beenstr;
    self.name.text = model.firstname;
    [self.image setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionProgressive];
    if (model.discounts.count != 0) {
        YSQPlayDiscountModel *disModel = model.discounts.firstObject;
        NSString *priceStr = [NSString stringWithFormat:@"%@元起",[YSQHelp GetPriceInStr:disModel.price]];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:priceStr];
        [attributedStr addAttribute:NSFontAttributeName value:YSQBoldFont range:NSMakeRange(0, priceStr.length - 2)];
         [attributedStr addAttribute:NSForegroundColorAttributeName value:YSQRed range:NSMakeRange(0, priceStr.length - 2)];
        self.price.attributedText = attributedStr;
    }
}

- (void)wantToPlay:(UIButton *)btn {
    UITableView *tableView = (id)[[self superview] superview];
    NSIndexPath *indexPath = [tableView indexPathForCell:self];
    btn.selected = !btn.selected;
    self.want.text = btn.selected ? @"已想去" : @"想去";
    if ([self.delegate respondsToSelector:@selector(loveWithIndex: isLove:)]) {
        [self.delegate loveWithIndex:indexPath.row isLove:btn.selected];
    }
}

- (void)createUI {
    
    self.love = [[UIButton alloc]init];
    [self.love setImage:[UIImage imageNamed:@"love_normal"] forState:UIControlStateNormal];
    [self.love setImage:[UIImage imageNamed:@"love_selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:self.love];
    [self.love addTarget:self action:@selector(wantToPlay:) forControlEvents:UIControlEventTouchUpInside];
    
    self.want = [UILabel new];
    self.want.textAlignment = NSTextAlignmentCenter;
    self.want.text = @"想去";
    self.want.textColor = YSQGray;
    self.want.font = YSQSamllFont;
    [self.contentView addSubview:self.want];
    
    
    self.image = [UIImageView new];
    [self.contentView addSubview:self.image];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(125, 56.66, 65, 23)];
    self.backView.backgroundColor = [UIColor clearColor];
    self.backView.clipsToBounds = YES;
    [self.contentView addSubview:self.backView];

    
    self.stars_count_light = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 23)];
    self.stars_count_light.image = [UIImage imageNamed:@"StarsForeground"];
    self.stars_count_light.clipsToBounds = YES;
    self.stars_count_light.tintColor = YSQGreenColor(1);
    self.stars_count_light.backgroundColor = [UIColor clearColor];
    [self.backView addSubview:self.stars_count_light];
    
    
    
    self.name = [UILabel new];
    self.name.textColor = YSQBlack;
    self.name.font = YSQSamllFont;
    [self.contentView addSubview:self.name];
    
    self.price = [UILabel new];
    self.price.textColor = YSQGray;
    self.price.font = YSQSamllFont;
    [self.contentView addSubview:self.price];
    
    self.count = [UILabel new];
    self.count.textColor = YSQGray;
    self.count.font = YSQSamllFont;
    [self.contentView addSubview:self.count];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-15);
        make.width.equalTo(@100);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.mas_right).offset(10);
        make.top.equalTo(self).offset(15);
    }];
    
    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-12);
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.mas_right).offset(10);
        make.bottom.equalTo(self.stars_count_light.mas_top).offset(-2);
    }];
    
    [self.love mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-25);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.want mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.love);
        make.top.equalTo(self.love.mas_bottom).offset(5);
    }];
    
}

- (void)setIsShow:(BOOL)isShow {
    _isShow = isShow;
    if (_isShow) {
        self.want.hidden = YES;
        self.love.hidden = YES;
    }
}

@end
