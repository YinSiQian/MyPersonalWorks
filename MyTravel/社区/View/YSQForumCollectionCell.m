//
//  YSQForumCell.m
//  MyTravel
//
//  Created by ysq on 16/3/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQForumCollectionCell.h"
#import "YSQGroupModel.h"


@interface YSQForumCollectionCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *count;

@end

@implementation YSQForumCollectionCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews {
    self.icon.layer.cornerRadius = 3;
    self.icon.layer.masksToBounds = YES;
}

- (void)setDataWithModel:(YSQGroupModel *)model {
    [self.icon setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionProgressive];
    self.name.text = model.name;
    self.count.text = [NSString stringWithFormat:@"%@个帖子",model.total_threads];
}

- (void)createUI {
    self.icon = [UIImageView new];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.icon];
    
    self.name = [UILabel new];
    self.name.textColor = YSQSteel;
    self.name.font = YSQSamllFont;
    self.name.numberOfLines = 2;
    [self.contentView addSubview:self.name];
    
    self.count = [UILabel new];
    self.count.textColor = YSQGray;
    self.count.font = YSQSamllFont;
    self.count.numberOfLines = 2;
    [self.contentView addSubview:self.count];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.width.equalTo(@50);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.right.equalTo(self).offset(-5);
        make.top.equalTo(self).offset(5);
    }];
    
    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.top.equalTo(self.name.mas_bottom).offset(5);
        make.right.equalTo(self).offset(-5);
    }];
}

- (void)customCornerRadius:(CGFloat)cornerRadius imageView:(UIImageView *)view{
    UIImage *image = view.image;
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:cornerRadius] addClip];
    [image drawInRect:view.bounds];
    view.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}


@end
