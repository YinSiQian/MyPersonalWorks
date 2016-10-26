//
//  YSQShowLocationViewController.m
//  MyTravel
//
//  Created by ysq on 16/6/27.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQShowLocationViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "YSQCityMapModel.h"
#import "YSQScenicSpotCell.h"
#import "HMSegmentedControl.h"
#import "YSQMoreCategoriesViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface YSQShowLocationViewController ()<MAMapViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate,YSQScenicSpotCellDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger viewCount;
@property (nonatomic, strong) YSQCityMapModel *kvoModel;
@property (nonatomic, assign) BOOL isScroll;
@property (nonatomic, assign) BOOL movedOutScreen;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;
@property (nonatomic, strong) HMSegmentedControl *segment;
@property (nonatomic, copy) NSString *cate_id;
@property (nonatomic, copy) NSString *tag_id;

@end

@implementation YSQShowLocationViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)annotations {
    if (!_annotations) {
        _annotations = [NSMutableArray array];
    }
    return _annotations;
}

#pragma mark --View life Cycle 

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0.9956)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _kvoModel = [[YSQCityMapModel alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.navTitle;
    _cate_id = @"151";
    [self initMapView];
    [self setupGestures];
    [self initCollectionView];
    [self createSegment];
    [self loadData];
    [_kvoModel addObserver:self forKeyPath:@"viewCount" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark --KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"viewCount"]) {
        if (_kvoModel.viewCount == self.dataArray.count) {
            MAPointAnnotation *point = self.annotations.firstObject;
            [self.mapView selectAnnotation:point animated:YES];
            [self.mapView setCenterCoordinate:point.coordinate animated:YES];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Initialization

- (void)createSegment {
    self.segment = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"景点观光",@"美食",@"购物",@"休闲娱乐",@"更多分类"]];
    self.segment.frame = CGRectMake(0, 64, WIDTH, 40);
    self.segment.backgroundColor = [UIColor whiteColor];
    self.segment.selectionIndicatorColor = YSQGreenColor(1);
    self.segment.selectedSegmentIndex = 0;
    self.segment.selectionIndicatorHeight = 2;
    self.segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segment.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:YSQBlack};
    self.segment.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.059 green:0.784 blue:0.490 alpha:1.000]};
    self.segment.borderType = HMSegmentedControlBorderTypeBottom;
    self.segment.borderColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    self.segment.borderWidth = 0.5;
    [self.view addSubview:self.segment];
    __weak typeof(self) weakSelf = self;
    [self.segment setIndexChangeBlock:^(NSInteger index) {
        weakSelf.tag_id = nil;
        switch (index) {
            case 0: {
                weakSelf.cate_id = @"151";
                [weakSelf loadData];
            }
                break;
            case 1: {
                weakSelf.cate_id = @"78";
                [weakSelf loadData];
            }
                break;
            case 2: {
                weakSelf.cate_id = @"147";
                [weakSelf loadData];
            }
                break;
            case 3: {
                weakSelf.cate_id = @"152";
                [weakSelf loadData];
            }
                break;
            case 4: {
                //更多分类
                YSQMoreCategoriesViewController *category = [[YSQMoreCategoriesViewController alloc]init];
                category.city_id = weakSelf.city_id;
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:category];
                [weakSelf.navigationController presentViewController:nav animated:YES completion:nil];
                category.callBack = ^(NSString *category_id, NSString *tag_id) {
                    weakSelf.cate_id = category_id;
                    weakSelf.tag_id = [NSString stringWithFormat:@"&tag_id=%@",tag_id];
                    [weakSelf loadData];
                };
            }
                break;
            default:
                break;
        }
     }];
}


- (void)initMapView {
    self.mapView = [[MAMapView alloc]init];
    self.mapView.frame = CGRectMake(0, 64+40, WIDTH, HEIGHT - 64 - 40);
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
}

- (void)setupGestures {
    // 需要额外添加一个双击手势，以避免当执行mapView的双击动作时响应两次单击手势。
    self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    self.doubleTap.delegate = self;
    self.doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:self.doubleTap];
    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTap.delegate = self;
    [self.singleTap requireGestureRecognizerToFail:self.doubleTap];
    [self.view addGestureRecognizer:self.singleTap];
}


- (void)initCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(WIDTH - 60, 90);
    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, HEIGHT - 130, WIDTH, 110) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[YSQScenicSpotCell class] forCellWithReuseIdentifier:@"ScenicSpot"];
}

- (void)initAnnotations {
    [self.annotations removeAllObjects];
    int count = (int)self.dataArray.count;
    CLLocationCoordinate2D coordinates[count];
    for (int i = 0; i < count; i++) {
        YSQCityMapModel *model = self.dataArray[i];
        coordinates[i].latitude = model.lat.doubleValue;
        coordinates[i].longitude = model.lng.doubleValue;
        MAPointAnnotation *point = [[MAPointAnnotation alloc]init];
        point.coordinate = coordinates[i];
        point.title =[model.cnname  isEqual: @""] ? model.enname : model.cnname;
        if ([point.title isEqualToString:@"XXX Gallery"]) {
            NSLog(@"%d",i);
        }
        [self.annotations addObject:point];
    }
    [self.mapView addAnnotations:self.annotations];
    [self.mapView showAnnotations:self.annotations animated:YES];
}

#pragma mark --数据请求

- (void)loadData {
    [_mapView removeAnnotations:self.annotations];
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_CITY_MAP_URL,_cate_id,self.city_id,_tag_id] success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        [self.dataArray removeAllObjects];
        NSDictionary *dict = responseObject[@"data"];
        NSArray *arr = dict[@"poi_list"];
        for (NSDictionary *dict in arr) {
            YSQCityMapModel *model = [YSQCityMapModel modelWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        [self.collectionView reloadData];
        [self initAnnotations];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        annotationView.pinColor                     = MKPinAnnotationColorGreen;
        _kvoModel.viewCount++;
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"accessory view :%@", view);
}

- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view {
    NSLog(@"callout view :%@", view);
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    if (!_isScroll) {//非滑动collectionView之后的选中
        MAPointAnnotation *point = (MAPointAnnotation *)view.annotation;
        int index = [self getSelectedAnnotationViewIndex:point.title];
        if (_movedOutScreen) {//collectionView移出屏幕外
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
                self.collectionView.alpha = 1;
                self.collectionView.frame = CGRectMake(0, HEIGHT - 130, WIDTH, 110);
            } completion:^(BOOL finished) {
                _movedOutScreen = NO;
               [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            }];
        } else {//collectionView还在屏幕内
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        [self.mapView setCenterCoordinate:point.coordinate animated:YES];
    } else {//滑动collectionView的选中的处理
        _isScroll = !_isScroll;
    }
}

#pragma mark --UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQScenicSpotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ScenicSpot" forIndexPath:indexPath];
    cell.delegate = self;
    YSQCityMapModel *model = self.dataArray[indexPath.item];
    [cell setDataWithModel:model];
    return cell;
}

#pragma mark --YSQScenicSpotCellDelegate 

- (void)wakeUpMAMapToNavigation:(NSInteger)index {
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    MAPointAnnotation *point = self.annotations[index];
    AMapNaviConfig *config = [[AMapNaviConfig alloc]init];
    config.destination = point.coordinate; //终点坐标，Annotation的坐标
    config.appScheme = [self getApplicationScheme];//返回的Scheme，需手动设置
    config.appName = infoDict[@"CFBundleDisplayName"];//应用名称，需手动设置
   //若未调起高德地图App,引导用户获取最新版本的
    if(![AMapURLSearch openAMapNavigation:config]) {
        [AMapURLSearch getLatestAMapApp];
    }
}

- (NSString *)getApplicationScheme {
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes)
    {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier])
        {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    NSLog(@"%@",scheme);
    return scheme;
}

#pragma mark --遍历数组找到当前选中的Annotation在数组中的索引
- (int)getSelectedAnnotationViewIndex:(NSString *)title {
    for (int index = 0; index < self.dataArray.count; index++) {
        YSQCityMapModel *model = self.dataArray[index];
        NSLog(@"%@",model.cnname);
        if ([model.cnname isEqualToString:title] ||[model.enname isEqualToString:title]) {
            return index;
        }
    }
    return 0;
}

#pragma mark --UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.collectionView) {
        //计算当前collectionView滑动到哪个item
        NSInteger itemIndex = scrollView.contentOffset.x / (WIDTH - 50);
        NSLog(@"%ld",itemIndex);
        MAPointAnnotation *point = self.annotations[itemIndex];
        //设置当前的point为中心点
        _isScroll = YES;
        [self.mapView selectAnnotation:point animated:YES];
        [self.mapView setCenterCoordinate:point.coordinate animated:YES];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%s",__func__);
    if (scrollView == self.collectionView) {
        //计算当前collectionView滑动到哪个item
        NSInteger itemIndex = scrollView.contentOffset.x / (WIDTH - 50);
        NSLog(@"%ld",itemIndex);
        MAPointAnnotation *point = self.annotations[itemIndex];
        //设置当前的point为中心点
        _isScroll = YES;
        [self.mapView selectAnnotation:point animated:YES];
        [self.mapView setCenterCoordinate:point.coordinate animated:YES];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer == self.singleTap && ([touch.view isKindOfClass:[UIControl class]] || [touch.view isKindOfClass:[MAAnnotationView class]] || [NSStringFromClass([touch.view class]) isEqualToString:@"HMScrollView"])) {
        return NO;
    }
    
    if (gestureRecognizer == self.doubleTap && [touch.view isKindOfClass:[UIControl class]]) {
        return NO;
    }
    return YES;
}

#pragma mark - Handle Gestures

- (void)handleSingleTap:(UITapGestureRecognizer *)theSingleTap {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        self.collectionView.alpha = 0.3;
        self.collectionView.frame = CGRectMake(0, HEIGHT, WIDTH, 110);
        _movedOutScreen = YES;
    } completion:^(BOOL finished) {
    }];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)theDoubleTap {
    
}


- (void)dealloc {
    [_kvoModel removeObserver:self forKeyPath:@"viewCount"];
}

@end
