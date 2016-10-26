//
//  YSQCommonHeaderCell.m
//  MyTravel
//
//  Created by ysq on 16/2/5.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQCommonHeaderCell.h"

@interface YSQCommonHeaderCell ()
@end

@implementation YSQCommonHeaderCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"common";
    YSQCommonHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[self  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return  self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.902 alpha:1.000].CGColor);
    CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width - 10, 1));
}

- (void)createUI {
    self.name = [UILabel new];
    self.name.textColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    self.name.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.name];
    
    self.seeAll = [UIButton new];
    [self.seeAll setTitle:@"查看全部 >" forState:UIControlStateNormal];
    self.seeAll.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.seeAll setTitleColor:[UIColor colorWithWhite:0.400 alpha:1.000] forState:UIControlStateNormal];
    [self.seeAll addTarget:self action:@selector(pushToSeeAllInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.seeAll];
    
    [self makeConstraint];
}

- (void)makeConstraint {
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(12);
    }];
    
    [self.seeAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
    }];
}

- (void)pushToSeeAllInfo {
    if ([self.delegate respondsToSelector:@selector(seeAllInfomationWithIsFreedom:)]) {
        [self.delegate seeAllInfomationWithIsFreedom:self.isFreedom];
    }
}

- (void)setIsFreedom:(BOOL)isFreedom {
    _isFreedom = isFreedom;
}

@end
