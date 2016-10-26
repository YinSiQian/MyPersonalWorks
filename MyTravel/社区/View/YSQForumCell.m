//
//  YSQForumCell.m
//  MyTravel
//
//  Created by ysq on 16/3/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQForumCell.h"
#import "YSQForumCollectionCell.h"
#import "YSQGroupModel.h"

@interface YSQForumCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSString *const forum = @"reuseCell";

@implementation YSQForumCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"forum";
    YSQForumCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[self  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCollectionView];
    }
    return  self;
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layou = [[UICollectionViewFlowLayout alloc]init];
    layou.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:layou];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.contentView addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[YSQForumCollectionCell class] forCellWithReuseIdentifier:forum];
    [self makeConstraint];
}

- (void)makeConstraint {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.groupArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(WIDTH /2 - 15, 60);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQForumCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:forum forIndexPath:indexPath];
    YSQGroupModel *model = self.groupArr[indexPath.item];
    [cell setDataWithModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(pushToForumDetailWithModel:)]) {
        YSQGroupModel *model = self.groupArr[indexPath.item];
        [self.delegate pushToForumDetailWithModel:model];
    }
}

- (void)setGroupArr:(NSArray *)groupArr {
    if (_groupArr != groupArr) {
        _groupArr = groupArr;
        [self.collectionView reloadData];
    }
}

@end
