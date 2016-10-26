//
//  YSQDiscountChooseView.m
//  MyTravel
//
//  Created by ysq on 16/4/15.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQDiscountChooseView.h"
#import "YSQSegmentCell.h"
#import "YSQDiscountOrderView.h"

@interface YSQDiscountChooseView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *colletionView;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation YSQDiscountChooseView

static NSString *reuseIdentifier = @"reuseIdentifier";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataArray = @[@"折扣类型",@"出发地",@"目的地",@"旅行时间"];
        [self createView];
    }
    return self;
}

- (void)createView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    self.colletionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, self.frame.size.height) collectionViewLayout:layout];
    self.colletionView.showsVerticalScrollIndicator = NO;
    self.colletionView.showsHorizontalScrollIndicator = NO;
    self.colletionView.delegate = self;
    self.colletionView.dataSource = self;
    self.colletionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.colletionView];
    [self.colletionView registerClass:[YSQSegmentCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark --UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQSegmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.title.text = self.dataArray[indexPath.item];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(WIDTH / 4, 40) ;
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.colletionView deselectItemAtIndexPath:indexPath animated:YES];
    for (int index = 0; index < self.dataArray.count; index ++) {
        YSQSegmentCell *cell = (YSQSegmentCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0 ]];
        if (index == indexPath.item) {
            cell.title.textColor = [UIColor redColor];
        } else {
            cell.title.textColor = YSQSteel;
        }
    }
    if ([self.delegate respondsToSelector:@selector(showMoreChoose:)]) {
        [self.delegate showMoreChoose:indexPath.item];
    }
}


@end
