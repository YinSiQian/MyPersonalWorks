//
//  YSQHotelCell.m
//  MyTravel
//
//  Created by ysq on 16/3/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotelCell.h"
#import "YSQCityHotelModel.h"

@interface YSQHotelCell ()
@property (nonatomic, strong) UILabel *cnname;
@property (nonatomic, strong) UILabel *enname;
@property (nonatomic, strong) UILabel *star;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *grade;
@property (nonatomic, strong) UIImageView *hotelImage;
@end

@implementation YSQHotelCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"hotelCell";
    YSQHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[self  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        self.backgroundColor = [UIColor colorWithRed:0.977 green:0.981 blue:0.970 alpha:1.000];
    }
    return  self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.902 alpha:1.000].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, .5));
}


- (void)setDataWithModel:(YSQCityHotelModel *)model {
    self.cnname.text = model.cnname;
    self.enname.text = model.enname;
    self.address.text = model.area_name;
    [self.hotelImage setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionProgressive];
    self.grade.text = [NSString stringWithFormat:@"%.1f分",model.ranking.floatValue];
    self.star.text = model.star;
    NSString *priceStr = [NSString stringWithFormat:@"%@  元起",model.price];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:priceStr];
    [attributedStr addAttribute:NSFontAttributeName value:YSQBoldFont range:NSMakeRange(0, priceStr.length - 2)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:YSQRed range:NSMakeRange(0, priceStr.length - 2)];
    self.price.attributedText = attributedStr;
    
}

- (void)createUI {
    self.cnname  = [UILabel new];
    self.cnname.font = YSQNormalFont;
    self.cnname.textColor = YSQSteel;
    self.cnname.numberOfLines = 2;
    [self.contentView addSubview:self.cnname];
    
    self.enname  = [UILabel new];
    self.enname.font = YSQSamllFont;
    self.enname.textColor = YSQGray;
    self.enname.numberOfLines = 1;
    [self.contentView addSubview:self.enname];
    
    
    self.star  = [UILabel new];
    self.star.font = YSQSamllFont;
    self.star.textColor = YSQOrange;
    [self.contentView addSubview:self.star];
    
    self.address  = [UILabel new];
    self.address.font = YSQSamllFont;
    self.address.textColor = YSQGray;
    [self.contentView addSubview:self.address];
    
    self.grade  = [UILabel new];
    self.grade.font = YSQNormalFont;
    self.grade.textColor = YSQSteel;
    self.grade.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.grade];
    
    self.price  = [UILabel new];
    self.price.font = YSQSamllFont;
    self.price.textColor = YSQGray;
    [self.contentView addSubview:self.price];
    
    self.hotelImage = [UIImageView new];
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.hotelImage];
    
    [self makeConstraint];
}

- (void)makeConstraint {
    [self.hotelImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@100);
    }];
    
    [self.cnname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotelImage.mas_right).offset(10);
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self.grade.mas_left).offset(-10);
    }];
    
    [self.enname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotelImage.mas_right).offset(10);
        make.top.equalTo(self.cnname.mas_bottom).offset(2);
        make.right.equalTo(self.grade.mas_left).offset(-10);
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotelImage.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    [self.star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotelImage.mas_right).offset(10);
        make.top.equalTo(self.enname.mas_bottom).offset(10);
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    [self.grade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(10);
    }];
}


@end
