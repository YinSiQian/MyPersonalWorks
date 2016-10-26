//
//  YSQTagView.m
//  MyTravel
//
//  Created by ysq on 16/8/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQTagView.h"

@interface YSQTagView ()

@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) NSMutableArray *lengthArr;
@end

@implementation YSQTagView

+ (instancetype)initWithTagArr:(NSArray *)titleArr {
    YSQTagView *tag = [[self alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    tag.titleArr = titleArr;
    return tag;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.widthToLeft = 10;
        self.widthToRight = 10;
        self.borderColor = [UIColor greenColor];
        self.titleColor = [UIColor blackColor];
        self.borderWidth = 1.0f;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"1");
    self.frame = CGRectMake(_widthToLeft, 10, WIDTH - _widthToLeft - _widthToRight, [self countHeight]);
    [self createTags];
}

- (void)createTags {
    CGFloat totalLength = 0;
     NSInteger plies = 0;
    for (int index = 0 ; index < _titleArr.count; index++) {
        CGFloat width = [self.lengthArr[index] floatValue];
        //换行  长度计算:上一次的总长度+即将布局的按钮的长度 + 离左右边界的长度 
        if (totalLength + width + 20 +self.widthToRight + self.widthToRight > WIDTH ) {
            totalLength = 0;
            plies += 1;
        }
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(totalLength,  43 * plies, width + 20, 30)];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:_titleArr[index] forState:UIControlStateNormal];
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        btn.layer.cornerRadius = _cornerRadius;
        btn.layer.borderColor = self.borderColor.CGColor;
        btn.layer.borderWidth = _borderWidth;
        [self addSubview:btn];
        totalLength += width + 20 + 20;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (CGFloat)countHeight {
    CGFloat totalLength = 0;
    NSInteger plies = 0;
    for (int index = 0 ; index < _titleArr.count; index++) {
        CGFloat width = [self.lengthArr[index] floatValue];
        //换行  长度计算:上一次的总长度+即将布局的按钮的长度 + 离左右边界的长度
        if (totalLength + width + 20 +self.widthToRight + self.widthToRight > WIDTH ) {
            totalLength = 0;
            plies += 1;
        }
        totalLength += width + 20 + 20;
    }
    return 43 *(plies + 1) + 10;
}

- (void)clickBtn:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(clickedBtn:)]) {
        [self.delegate clickedBtn:btn.currentTitle];
    }
    if (self.didTagResponse) {
        self.didTagResponse(btn.currentTitle);
    }
}

- (void)countTitleLength {
    for (int index = 0; index < self.titleArr.count; index++) {
        CGFloat width = [NSString sizeWithText:self.titleArr[index] font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(WIDTH, 30)].width;
        [self.lengthArr addObject:@(width)];
    }
}

- (NSMutableArray *)lengthArr {
    if (!_lengthArr) {
        _lengthArr = [NSMutableArray array];
    }
    return _lengthArr;
}

- (void)setTitleArr:(NSArray *)titleArr {
    _titleArr = titleArr;
    [self countTitleLength];
}


@end
