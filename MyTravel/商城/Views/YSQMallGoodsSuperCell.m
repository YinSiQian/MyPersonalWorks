//
//  YSQMallGoodsSuperCell.m
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQMallGoodsSuperCell.h"
#import "YSQMallGoodsCell.h"
#import "YSQMallHotGoodsModel.h"

@interface YSQMallGoodsSuperCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *title;

@end

static NSString *const reuse = @"goods";

@implementation YSQMallGoodsSuperCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"YSQMallGoodsSuperCell";
    YSQMallGoodsSuperCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[YSQMallGoodsSuperCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubviews];
    }
    return  self;
}

- (void)createSubviews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((WIDTH - 3 * 15) / 2, 170);
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YSQMallGoodsCell" bundle:[NSBundle mainBundle]]  forCellWithReuseIdentifier:reuse];
    [self.contentView addSubview:self.collectionView];
    
    self.title = [UILabel new];
    self.title.textColor = [UIColor blackColor];
    self.title.font = [UIFont boldSystemFontOfSize:15];
    self.title.text = @"有好货";
    [self.contentView addSubview:self.title];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(20);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(10);
        make.left.and.right.and.bottom.equalTo(self).offset(0);
    }];
}

- (void)setModelArr:(NSArray *)modelArr {
    _modelArr = modelArr;
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQMallGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuse forIndexPath:indexPath];
    YSQMallHotGoodsModel *model = self.modelArr[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
