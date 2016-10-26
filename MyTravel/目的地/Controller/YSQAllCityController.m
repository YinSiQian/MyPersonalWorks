//
//  YSQAllCityController.m
//  MyTravel
//
//  Created by ysq on 16/3/23.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQAllCityController.h"
#import "YSQAllCityCell.h"
#import "YSQAllCityModel.h"
#import "YSQCityDetailViewController.h"

@interface YSQAllCityController ()

@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YSQAllCityController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark ---懒加载

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark ---view life cycle
- (void)loadView {
    [self createCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部城市";
    self.page = 1;
    [SQProgressHUD showHUDToView:self.view animated:YES];
    [self loadData];
    [self createRefreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---UI 

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[YSQAllCityCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)createRefreshView {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.collectionView.mj_footer = footer;
    footer.automaticallyRefresh = YES;
    footer.automaticallyHidden = YES;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self loadData];
    }];
    self.collectionView.mj_header = header;
}


#pragma mark --- 网络请求

- (void)loadData {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_ALL_CITY_URL,self.ID,self.page] success:^(id responseObject) {
        [SQProgressHUD hideHUDToView:self.view animated:YES];
        NSArray *data = responseObject[@"data"];
        if (data.count == 0) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
            [self.collectionView.mj_header endRefreshing];
        } else {
            [self.collectionView.mj_footer endRefreshing];
        }
        for (NSDictionary *dict in data) {
            YSQAllCityModel *model = [YSQAllCityModel modelWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        self.page ++;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [SQProgressHUD hideHUDToView:self.view animated:YES];
        NSLog(@"%@",error);
    }];
}

#pragma mark <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake((WIDTH - 30) / 2, 180) ;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQAllCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    YSQAllCityModel *model = self.dataArray[indexPath.item];
    [cell setDataWithModel:model];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQAllCityModel *model = self.dataArray[indexPath.item];
    YSQCityDetailViewController *cityDetail = [[YSQCityDetailViewController alloc]init];
    cityDetail.BarName = model.catename;
    cityDetail.ID = [NSNumber numberWithInteger:model.ID.integerValue];
    [self.navigationController pushViewController:cityDetail animated:YES];
}


@end
