//
//  DestinationViewController.m
//  MyTravel
//
//  Created by ysq on 16/1/3.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "DestinationViewController.h"
#import "YSQDistinctViewController.h"
#import "YSQLabelView.h"
#import "YSQContinent.h"
#import "YSQCountry.h"
#import "YSQCountryCollectionViewCell.h"
#import "YSQNormalCountryCell.h"
#import "YSQCollectionHeaderView.h"

@interface DestinationViewController ()<YSQLabelViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) YSQLabelView *labelView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger index;
@end

static  NSString *const  reuse = @"collectionCell";
static  NSString *const  normalCell = @"normal";
static  NSString *const  reuseHeader = @"reuseHeader";

@implementation DestinationViewController

#pragma mark ---懒加载
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSArray *)cityArray {
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

#pragma mark ---view life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //解决Scrollview自动向下滑动64的单位的问题,当导航栏改变透明度的时候.
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQGreenColor(1.0)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.index = 0;
    [self loadData];
    [self createTopChoose];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark ---数据请求
- (void)loadData {
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [NetWorkManager getDataWithURL:MT_CITY_URL success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSArray *array = [responseObject objectForKey:@"data"];
        NSMutableArray *countryArr = [NSMutableArray array];
        NSMutableArray *hotCountryArr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            [countryArr removeAllObjects];
            [hotCountryArr removeAllObjects];
            YSQContinent *continent = [YSQContinent modelWithDictionary:dict];
            for (NSDictionary *dict in continent.country) {
                YSQCountry *country = [YSQCountry modelWithDictionary:dict];
                [countryArr addObject:country];
            }
            continent.country = [countryArr copy];
            for (NSDictionary *dict in continent.hot_country) {
                YSQCountry *hotcountry = [YSQCountry modelWithDictionary:dict];
                [hotCountryArr addObject:hotcountry];
            }
            continent.hot_country = [hotCountryArr copy];
            [self.dataArray addObject:continent];
        }
        [self createCollectionView];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

#pragma mark ---UI构建

- (void)createTopChoose {
    NSArray *titleArray = @[@"亚洲",@"欧洲",@"北美洲",@"南美洲",@"大洋洲",@"非洲",@"南极洲"];
    self.labelView = [YSQLabelView labelView:CGRectMake(0, 64, WIDTH, 40) titleArray:titleArray delegate:self];
    self.labelView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    self.labelView.selectedTitleColor = [UIColor colorWithRed:1.000 green:0.292 blue:0.248 alpha:1.000];
    [self.view addSubview:self.labelView];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,40 + 64, WIDTH, HEIGHT - 64 -  40 - 49) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[YSQCountryCollectionViewCell class] forCellWithReuseIdentifier:reuse];
    [self.collectionView registerClass:[YSQNormalCountryCell class] forCellWithReuseIdentifier:normalCell];
    [self.collectionView registerClass:[YSQCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader];
    [self.view addSubview:self.collectionView];
}

#pragma mark ---UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQContinent *continent = self.dataArray[self.index];
    YSQCountry *model = indexPath.section == 0 ? continent.hot_country[indexPath.row] : continent.country[indexPath.row];
    YSQDistinctViewController *distinct = [[YSQDistinctViewController alloc]init];
    distinct.name = model.cnname;
    distinct.ID = model.ID;
    [self.navigationController pushViewController:distinct animated:YES];
}

#pragma mark --- UICollectionViewDataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    YSQCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader forIndexPath:indexPath];
    headerView.title.text = @"热门地区";
    if (indexPath.section == 1) {
        headerView.title.text = @"其他地区";
    }
    return headerView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    YSQContinent *contient = self.dataArray[self.index];
    return  section == 0 ? contient.hot_country.count:contient.country.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(WIDTH, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? CGSizeMake((WIDTH - 30) / 2, 200) : CGSizeMake(WIDTH , 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return section == 0 ? UIEdgeInsetsMake(10, 10, 10, 10) :UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQContinent *contient = self.dataArray[self.index];
    if (indexPath.section == 0) {
        YSQCountry *country = contient.hot_country[indexPath.row];
        YSQCountryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuse forIndexPath:indexPath];
        [cell setDataWithModel:country];
        return cell;
    } else {
        YSQCountry *country = contient.country[indexPath.row];
        YSQNormalCountryCell *normalCountry = [collectionView dequeueReusableCellWithReuseIdentifier:normalCell forIndexPath:indexPath];
        [normalCountry setDataWithModel:country];
        return normalCountry;
    }
}

#pragma mark ---YSQLabelViewDataSource

- (void)labelView:(YSQLabelView *)labelView didSelectedIndex:(NSInteger)index {
    self.index = index;
    [self.collectionView reloadData];
}

@end
