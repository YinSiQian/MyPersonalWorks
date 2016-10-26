//
//  YSQAllDiscountViewController.m
//  MyTravel
//
//  Created by ysq on 16/4/14.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQAllDiscountViewController.h"
#import "YSQAllDiscountCell.h"
#import "YSQAllDiscountModel.h"
#import "YSQWebViewController.h"
#import "YSQDiscountOrderView.h"
#import "YSQDiscountChooseView.h"
#import "YSQChooseTypeModel.h"
#import "YSQCityChooseView.h"

typedef NS_ENUM(NSInteger,YSQLoadDataType) {
    YSQLoadDataTypeNormal,
    YSQLoadDataTypeOrder,
    YSQLoadDataTypePick,
};

@interface YSQAllDiscountViewController ()<YSQDiscountOrderViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,YSQDiscountChooseViewDelegate,YSQDiscountOrderViewStatusChangedDelegate,YSQDiscountOrderViewDataSource,YSQCityChooseViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) YSQDiscountOrderView *orderView;
@property (nonatomic, strong) YSQChooseTypeModel *typeModel;
@property (nonatomic, strong) YSQDiscountChooseView *chooseView;
@property (nonatomic, strong) YSQDiscountOrderView *typeView;
@property (nonatomic, strong) YSQDiscountOrderView *startDesView;
@property (nonatomic, strong) YSQDiscountOrderView *timeView;
@property (nonatomic, strong) YSQCityChooseView *cityView;
@property (nonatomic, assign) YSQLoadDataType dataType;
@property (nonatomic, copy) NSString *orderType;

@property (nonatomic, assign) BOOL isShow;

@end

@implementation YSQAllDiscountViewController {
    NSString *_departure;
    NSString *_times;
    NSNumber *_ID;
    NSNumber *_countryID;
    NSNumber *_continetID;
}

static NSString * const reuseIdentifier = @"Cell";

#pragma mark --懒加载

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)viewArray {
    if (!_viewArray) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

- (YSQDiscountOrderView *)orderView {
    if (!_orderView) {
        _orderView = [YSQDiscountOrderView initWithTitlesArray:@[@"默认",@"销量从高到低",@"价格从低到高",@"价格从高到低",@"今日最新"]];
        _orderView.delegate = self;
        _orderView.statusDelegate = self;
        [self.view insertSubview:_orderView belowSubview:self.chooseView];
        [self.viewArray addObject:_orderView];
    }
    return _orderView;
}

- (YSQDiscountOrderView *)typeView {
    if (!_typeView) {
        _typeView = [YSQDiscountOrderView initWithModelArray:self.typeModel.type];
        _typeView.statusDelegate = self;
        _typeView.dataSource = self;
        [self.view insertSubview:_typeView belowSubview:self.chooseView];
        [self.viewArray addObject:_typeView];
    }
    return _typeView;
}

- (YSQDiscountOrderView *)startDesView {
    if (!_startDesView) {
        _startDesView = [YSQDiscountOrderView initWithModelArray:self.typeModel.departure];
        _startDesView.statusDelegate = self;
        _startDesView.dataSource = self;
        [self.view insertSubview:_startDesView belowSubview:self.chooseView];
        [self.viewArray addObject:_startDesView];
    }
    return _startDesView;
}

- (YSQDiscountOrderView *)timeView {
    if (!_timeView) {
        _timeView = [YSQDiscountOrderView initWithModelArray:self.typeModel.times_drange];
        _timeView.statusDelegate = self;
        _timeView.dataSource = self;
        [self.view insertSubview:_timeView belowSubview:self.chooseView];
        [self.viewArray addObject:_timeView];
    }
    return _timeView;
}

- (YSQCityChooseView *)cityView {
    if (!_cityView) {
        _cityView = [YSQCityChooseView initWithDataArray:self.typeModel.poi];
        _cityView.delegate = self;
        [self.view insertSubview:_cityView belowSubview:self.chooseView];
        [self.viewArray addObject:_cityView];
    }
    return _cityView;
}

- (void)initData {
    _ID = @0;
    _times = @"";
    _departure = @"";
    _countryID = @0;
    _continetID = @0;
    self.page = 1;
}

#pragma mark -- View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
     self.selectedIndex = 100;
    self.dataType = YSQLoadDataTypeNormal;
    [self initData];
    [self createColletionView];
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [self createRefreshView];
    [self createOrderItem];
    [self createChooseView];
    [self loadData];
    [self loadChooseData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --UI 

- (void)createColletionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset =  UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[YSQAllDiscountCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)createOrderItem {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    btn.tag = 10;
    [btn setBackgroundImage:[UIImage imageNamed:@"order_item"] forState:UIControlStateNormal];
    btn.tintColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(chooseOrderItem:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

- (void)createChooseView {
    self.chooseView = [[YSQDiscountChooseView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 40)];
    self.chooseView .delegate = self;
    self.chooseView .backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.chooseView];
}

- (void)createRefreshView {
    __weak typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        switch (weakSelf.dataType) {
            case YSQLoadDataTypePick: {
                [weakSelf loadPickedData];
            }
                break;
            case YSQLoadDataTypeOrder: {
                [weakSelf loadOrderedData];
            }
                break;
            case YSQLoadDataTypeNormal: {
                [weakSelf loadData];
            }
                break;
            default:
                break;
        }
    }];
    self.collectionView.mj_footer = footer;
    footer.automaticallyRefresh = YES;
    footer.automaticallyHidden = YES;
}

#pragma mark --网络请求

- (void)loadData {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_ALLDISCOUNT_URL,self.page] success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSDictionary *data = responseObject[@"data"];
        NSArray *lastminutes = data[@"lastminutes"];
        if (lastminutes.count == 0) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.collectionView.mj_footer endRefreshing];
        for (NSDictionary *dict in lastminutes) {
            YSQAllDiscountModel *model = [YSQAllDiscountModel modelWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        self.page ++;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

- (void)loadOrderedData {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_DISCOUNT_ORDER_URL,self.page,self.orderType] success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSDictionary *data = responseObject[@"data"];
        NSArray *lastminutes = data[@"lastminutes"];
        if (lastminutes.count == 0) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.collectionView.mj_footer endRefreshing];
        [self.dataArray removeAllObjects];
        for (NSDictionary *dict in lastminutes) {
            YSQAllDiscountModel *model = [YSQAllDiscountModel modelWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        self.page ++;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

- (void)loadChooseData {
    [NetWorkManager getDataWithURL:YSQ_DISCOUNT_CHOOSE_URL success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSDictionary *data = responseObject[@"data"];
        self.typeModel = [YSQChooseTypeModel modelWithDictionary:data];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

- (void)loadPickedData {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_DISCOUNT_PICK_URL,_continetID,_countryID,_departure,self.page,_ID,_times] success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSDictionary *data = responseObject[@"data"];
        NSArray *lastminutes = data[@"lastminutes"];
        if (lastminutes.count == 0) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        for (NSDictionary *dict in lastminutes) {
            YSQAllDiscountModel *model = [YSQAllDiscountModel modelWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        [self.collectionView.mj_footer endRefreshing];
        self.page ++;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake((WIDTH - 30) / 2, 180) ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQAllDiscountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    YSQAllDiscountModel *model = self.dataArray[indexPath.item];
    [cell setDataWithModel:model];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    YSQAllDiscountModel *model = self.dataArray[indexPath.item];
    web.ID = [NSNumber numberWithInteger:model.ID.integerValue];
    [self.navigationController pushViewController:web animated:YES];
}

#pragma mark --- NavigationItemAction

- (void)chooseOrderItem:(UIButton *)btn {
    //当点击button的时候重置selectedIndex的值,避免当点击完button后,再次重复点击chooseView上次点击的按钮时不展示对应的view
    self.selectedIndex = 100;
    if (self.isShow) {
        //将已经展开的视图收回去,展示新的视图.
        [self hideAllShowView];
    }
    btn.selected = !btn.selected;
    if (btn.selected) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self startTransitionWithViewRect:CGRectMake(0, 64 + 40, WIDTH, HEIGHT) type:kCATransitionMoveIn subtype:kCATransitionFromBottom moveView:self.orderView];
            self.isShow = YES;
        });
    }
}

- (void)startTransitionWithViewRect:(CGRect)rect type:(NSString *)type subtype:(NSString *)subtype moveView:(UIView *)moveView{
    moveView.frame = rect;
    CATransition *transition = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.startProgress = 0;
    transition.endProgress = 0.8;
    transition.type = type;
    transition.subtype = subtype;
    transition.duration = 0.2;
    [moveView.layer addAnimation:transition forKey:nil];
}

#pragma mark -- YSQDiscountOrderViewDelegate

- (void)orderDiscountInfoWithType:(NSString *)type {
    UIButton *btn = (UIButton *)[self.navigationController.navigationBar viewWithTag:10];
    btn.selected = !btn.selected;
    self.page = 1;
    if ([type isEqualToString:@"Default"]) {
        [self.dataArray removeAllObjects];
        [self loadData];
    } else {
        self.dataType = YSQLoadDataTypeOrder;
        self.orderType = type;
        [self loadOrderedData];
    }
    [self startTransitionWithViewRect:CGRectMake(0, -HEIGHT, WIDTH, HEIGHT) type:@"fade" subtype:kCATransitionFromTop moveView:self.orderView];
    [self.collectionView scrollToTop];
}

#pragma mark --YSQDiscountOrderViewStatusChangedDelegate

- (void)changedButtonSelected {
    [self commonChangedWithBarItem];
}

#pragma mark --YSQDiscountOrderViewDataSource

- (void)sendDataInDict:(NSDictionary *)dataDict {
    self.dataType = YSQLoadDataTypePick;
    [self hideAllShowView];
    self.page = 1;
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    if ([dataDict[@"value"] isKindOfClass:[YSQTypeModel class]]) {
        YSQTypeModel *model = dataDict[@"value"];
        _ID = model.ID;
    } else if ([dataDict[@"value"] isKindOfClass:[YSQTimesModel class]]) {
        YSQTimesModel *model = dataDict[@"value"];
        _times = model.times;
    } else if ([dataDict[@"value"] isKindOfClass:[YSQDepartureModel class]]) {
        YSQDepartureModel *model = dataDict[@"value"];
        _departure = model.city;
    }
    [self.dataArray removeAllObjects];
    [self loadPickedData];
}

#pragma mark --YSQCityChooseViewDelegate

- (void)sendCityValue:(NSNumber *)continetID countryID:(NSNumber *)countryID {
    [self hideAllShowView];
    self.dataType = YSQLoadDataTypePick;
    self.page = 1;
    _continetID = continetID;
    _countryID = continetID;
    [self.dataArray removeAllObjects];
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [self loadPickedData];
}

-(void)changedBarItemStatus {
    [self commonChangedWithBarItem];
}

#pragma mark --YSQDiscountChooseViewDelegate

- (void)showMoreChoose:(NSInteger)index {
    if (self.selectedIndex == index && self.isShow) {
        [self commonChangedWithBarItem];
        [self hideAllShowView];
        return;
    }
    self.selectedIndex = index;
    [self hideAllShowView];
    self.isShow = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        switch (index) {
            case 0: {
                [self startTransitionWithViewRect:CGRectMake(0, 64 + 40, WIDTH, HEIGHT) type:kCATransitionMoveIn  subtype:kCATransitionFromBottom moveView:self.typeView];
                break;
            }
            case 1: {
                [self startTransitionWithViewRect:CGRectMake(0, 64 + 40, WIDTH, HEIGHT) type:kCATransitionMoveIn  subtype:kCATransitionFromBottom moveView:self.startDesView];
                break;
            }
            case 2: {
                [self startTransitionWithViewRect:CGRectMake(0, 64 + 40, WIDTH, HEIGHT) type:kCATransitionMoveIn  subtype:kCATransitionFromBottom moveView:self.cityView];
                break;
            }
            case 3: {
                [self startTransitionWithViewRect:CGRectMake(0, 64 + 40, WIDTH, HEIGHT) type:kCATransitionMoveIn  subtype:kCATransitionFromBottom moveView:self.timeView];
                break;
            }
            default:
                break;
        }
    });
}

- (void)commonChangedWithBarItem {
    UIButton *btn = (UIButton *)[self.navigationController.navigationBar viewWithTag:10];
    btn.selected = btn.selected ? !btn.selected : btn.selected;
    self.isShow = NO;
}

- (void)hideAllShowView {
    for (UIView *view in self.viewArray) {
        if (view.origin.y > 100) {
            [self startTransitionWithViewRect:CGRectMake(0, -HEIGHT, WIDTH, HEIGHT) type:@"fade"  subtype:kCATransitionFromTop moveView:view];
        }
    }
    self.isShow = NO;
}

@end
