//
//  YSQLabelView.m
//  MyTravel
//
//  Created by ysq on 16/2/5.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQLabelView.h"

@interface YSQLabelView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, assign) CGFloat moveLength;
@property (nonatomic, assign) CGFloat segmentWidth;
@property (nonatomic, assign) CGFloat selectedIndex;

@end

@implementation YSQLabelView

+ (instancetype)labelView:(CGRect)frame titleArray:(NSArray *)array delegate:(id)delegate{
    YSQLabelView *labelView = [[YSQLabelView alloc]initWithFrame:frame];
    labelView.titleArray = [array copy];
    [labelView addBtn];
    labelView.datasource = delegate;
    return labelView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.segmentWidth = 0;
        self.normalTitleColor = [UIColor grayColor];
        self.selectedTitleColor = [UIColor colorWithRed:0.258 green:0.640 blue:0.113 alpha:1.000];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)addBtn {
    [self removeAllSubviews];
    [self.btnArray removeAllObjects];
    [self countSegmentWidth];
    NSInteger index = 0;
    for (NSString *title in self.titleArray) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.segmentWidth * index, 5, self.segmentWidth, 30)];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = index + 1;
        if (index == 0) {
            btn.selected = YES;
            btn.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        [btn addTarget:self action:@selector(reloadCountryData:) forControlEvents:UIControlEventTouchUpInside];
        index ++;
        [self.btnArray addObject:btn];
        [self addSubview:btn];
    }
    self.contentSize = CGSizeMake(self.titleArray.count * self.segmentWidth , 1);
}

- (void)countSegmentWidth {
    [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat titleWidth = [NSString sizeWithText:self.titleArray[idx] font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(WIDTH, 30)].width + 20 + 10;
        self.segmentWidth = MAX(titleWidth, self.segmentWidth);
    }];
}

- (void)reloadCountryData:(UIButton *)btn {
    self.selectedIndex = btn.tag - 1;
    [self scrollToSelectedIndex];
    for (UIButton *button in self.btnArray) {
        if (button.tag == btn.tag) {
            button.selected = YES;
            [UIView animateWithDuration:.3 animations:^{
                button.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
            }];
        } else {
            button.selected = NO;
            [UIView animateWithDuration:.3 animations:^{
                button.transform = CGAffineTransformScale(self.transform, 1.0, 1.0);
            }];
        }
    }
    if ([self.datasource respondsToSelector:@selector(labelView:didSelectedIndex:)]) {
        [self.datasource labelView:self didSelectedIndex:btn.tag - 1];
    }
    
}

- (void)scrollToSelectedIndex {
    CGRect rectOfSelectedIndex = CGRectMake(self.segmentWidth * self.selectedIndex, 0, self.segmentWidth, self.frame.size.height);
    CGFloat selectedSegmentOffset = (CGRectGetWidth(self.frame) / 2) - (self.segmentWidth / 2);
    CGRect rectToScrollTo = rectOfSelectedIndex;
    rectToScrollTo.origin.x -= selectedSegmentOffset;
    rectToScrollTo.size.width += selectedSegmentOffset * 2;
    [self scrollRectToVisible:rectToScrollTo animated:YES];
}

- (NSArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor {
    _normalTitleColor = normalTitleColor;
    for (UIButton *btn in self.btnArray) {
        [btn setTitleColor:_normalTitleColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    for (UIButton *btn in self.btnArray) {
        [btn setTitleColor:_selectedTitleColor forState:UIControlStateSelected];
    }
}

@end
