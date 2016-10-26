//
//  YSQForumHeaderView.m
//  MyTravel
//
//  Created by ysq on 16/4/30.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQForumHeaderView.h"
#import "YSQForumDetailModel.h"

@interface YSQForumHeaderView ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *counts;
@property (nonatomic, strong) UIImageView *backImg;
@property (nonatomic, strong) UIView *line;

@end

@implementation YSQForumHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubviews];
        [self makeConstraints];
    }
    return self;
}

- (void)setDataWithModel:(YSQForumDetailModel *)model {
    __weak typeof(self) weakSelf = self;
    [self.icon setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionProgressive];
    [self.backImg setImageWithURL:[NSURL URLWithString:model.photo] placeholder:nil options:YYWebImageOptionProgressive completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            weakSelf.backImg.image = [image imageByBlurRadius:10 tintColor:[UIColor colorWithWhite:1 alpha:0.2] tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
        });
    }];
    self.counts.text = model.total;
}

- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset {
    CGRect frame = self.backImg.frame;
    CGFloat offsetY = offset.y;
    if (offsetY > 0) {
        frame.origin.y = MAX(offsetY * 0.5, 0);
        self.backImg.frame = frame;
        self.clipsToBounds = YES;
    } else {
        CGFloat delta = 0.0f;
        CGRect rect = CGRectMake(0, 0, WIDTH, 200);
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        self.backImg.frame = rect;
        self.clipsToBounds = NO;
    }
}

- (void)createSubviews {
    self.backImg = [UIImageView new];
    [self addSubview:self.backImg];
    
    self.backView = [UIView new];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    self.icon = [UIImageView new];
    self.icon.layer.cornerRadius = 2;
    self.icon.layer.masksToBounds = YES;
    [self addSubview:self.icon];
    
    self.counts = [UILabel new];
    self.counts.textColor = [UIColor whiteColor];
    self.counts.font = YSQSamllFont;
    [self addSubview:self.counts];
    
    self.line = [UIView new];
    self.line.backgroundColor = YSQGray;
    [self addSubview:self.line];
    
}

- (void)makeConstraints {
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.equalTo(@40);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.and.height.equalTo(@60);
    }];
    
    [self.counts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.bottom.equalTo(self.backView.mas_top).offset(-5);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.equalTo(@0.5);
    }];
}

@end
