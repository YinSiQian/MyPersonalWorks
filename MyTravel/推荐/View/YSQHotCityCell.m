//
//  YSQHotCityCell.m
//  MyTravel
//
//  Created by ysq on 16/5/24.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotCityCell.h"
#import "YSQAddressModel.h"
#import "YSQHotCollectionCell.h"

@interface YSQHotCityCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YSQHotCityCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"hotCell";
    YSQHotCityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[self  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCollectionView];
    }
    return  self;
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((WIDTH - 60) / 3, 50);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 25, WIDTH, 200) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView registerClass:[YSQHotCollectionCell class] forCellWithReuseIdentifier:@"hotItem"];
}

#pragma mark --UICollectionViewDataSource 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQHotCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotItem" forIndexPath:indexPath];
    YSQAddressModel *model = self.dataArr[indexPath.item];
    [cell setDataWithModel:model];
    return cell;
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    [self.collectionView reloadData];
}

@end
