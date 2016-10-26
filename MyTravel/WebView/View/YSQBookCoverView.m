//
//  YSQBookCoverView.m
//  MyTravel
//
//  Created by ysq on 16/6/14.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQBookCoverView.h"

@interface YSQBookCoverView ()

@property (nonatomic, strong) UIScrollView *coverScrollView;
@property (nonatomic, strong) UIImageView *tileImage;
@property (nonatomic, strong) UIImageView *coverImage;

@end

@implementation YSQBookCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    self.coverScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 2 / 3.0 * HEIGHT)];
    self.coverScrollView.contentSize = CGSizeMake(2 * WIDTH, 2 / 3.0 * HEIGHT);
    [self addSubview:self.coverScrollView];
    
    self.coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2 * WIDTH, 2 / 3.0 * HEIGHT)];
    [self.coverScrollView addSubview:self.coverImage];
    
    self.tileImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2 / 3.0 * HEIGHT, WIDTH, 1 / 3.0 * HEIGHT)];
    [self addSubview:self.tileImage];
}

- (void)loadCoverImage:(NSString *)coverPath titleImage:(NSString *)titlePath {
    self.coverImage.image = [UIImage imageWithContentsOfFile:coverPath];
    self.tileImage.image = [UIImage imageWithContentsOfFile:titlePath];
}

- (void)starAnimation:(void(^)(YSQBookCoverView *cover))completion {
    [UIView animateWithDuration:3.0f animations:^{
        [self.coverScrollView setContentOffset:CGPointMake(WIDTH, 1)];
    } completion:^(BOOL finished) {
        completion(self);
    }];
}

@end
