//
//  YSQMineHeaderView.m
//  MyTravel
//
//  Created by ysq on 16/5/28.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQMineHeaderView.h"


@interface YSQMineHeaderView ()

@property (nonatomic, strong) UIImageView *blurImage;
@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation YSQMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubviews];
        [self makeConstraints];
        [self setImageData];
    }
    return self;
}

- (void)layoutSubviews {
    self.icon.layer.cornerRadius = self.icon.height / 2;
    self.icon.layer.masksToBounds = YES;
}

- (void)createSubviews {
    self.backImage = [UIImageView new];
    self.backImage.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.backImage];
    
    //iOS8新特性 毛玻璃
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    self.effectView.frame = self.frame;
    self.effectView.alpha = 0.0f;
    [self addSubview:self.effectView];
    
    self.icon = [UIButton new];
    [self addSubview:self.icon];
    
    self.name = [UILabel new];
    self.name.font = YSQNormalFont;
    self.name.backgroundColor = [UIColor clearColor];
    self.name.textColor = [UIColor whiteColor];
    self.name.text = @"未登录";
    [self addSubview:self.name];
    
    
}

- (void)makeConstraints {
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.height.and.width.equalTo(@60);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(5);
        make.centerX.equalTo(self);
    }];
}

- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset {
    CGFloat offsetY = offset.y;
    
    if (offsetY > 0) {
        
    } else {
        if (offsetY < -64) {
            offsetY = -64;
        }
        CGFloat delta = 0.0f;
        CGRect rect = CGRectMake(0, 0, WIDTH, 240);
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        self.backImage.frame = rect;
        self.effectView.frame = rect;
//        self.effectView.backgroundColor = [UIColor colorWithWhite:0.984 alpha:fabs(offsetY) / 64.0];
        self.effectView.alpha = fabs(offsetY) / 64.0;
        self.clipsToBounds = NO;
    }

}

- (void)setImageData {
    [self.icon setBackgroundImageWithURL:[NSURL URLWithString:@"http://static.qyer.com/images/user2/avatar/big1.png"] forState:UIControlStateNormal options:YYWebImageOptionProgressive];
    [self.backImage setImageWithURL:[NSURL URLWithString:@"http://static.qyer.com/images/user2/index/headImage_lite.png"] options:YYWebImageOptionProgressive];
}



- (UIImage *)screenShotOfView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 0.0);
    [self drawViewHierarchyInRect:self.frame afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
