//
//  YSQStrategyViewController.m
//  MyTravel
//
//  Created by ysq on 16/4/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQStrategyViewController.h"
#import "XLPlainFlowLayout.h"
#import "YSQKitsTypeModel.h"
#import "YSQKitsModel.h"
#import "YSQKitsCell.h"
#import "YSQKitsReusableView.h"
#import "YSQStrategyDetailController.h"

@interface YSQStrategyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *leftListArr;
@property (nonatomic, strong) NSMutableArray *rightListArr;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, assign) BOOL isCompeleted;
@property (nonatomic, assign) BOOL isAllCompeleted;


@end

static NSString *kitsCell = @"kitsCell";
static NSString *resuableView = @"resuableView";

@implementation YSQStrategyViewController



#pragma mark ---懒加载

- (NSMutableArray *)leftListArr {
    if (!_leftListArr) {
        _leftListArr = [NSMutableArray array];
    }
    return _leftListArr;
}

- (NSMutableArray *)rightListArr {
    if (!_rightListArr) {
        _rightListArr = [NSMutableArray array];
    }
    return _rightListArr;
}

#pragma  mark --View lifte cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"看锦囊";
    self.ID = @999999;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self createCollectionView];
    [self loadLeftListData];
    [self loadRightListData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark --- 网络

- (void)loadLeftListData {
    [NetWorkManager getDataWithURL:YSQ_KITS_LEFT_LIST_URL success:^(id responseObject) {
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dict in data) {
            YSQKitsTypeModel *model = [YSQKitsTypeModel modelWithDictionary:dict];
            [self.leftListArr addObject:model];
        }
        [self.tableView reloadData];
        //设置首个cell默认选中
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

- (void)loadRightListData {
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_KITS_RIGHT_LIST_URL,self.ID] success:^(id responseObject) {
         [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSArray *data  = responseObject[@"data"];
        [self.rightListArr removeAllObjects];
        for (NSDictionary *dict in data) {
            YSQKitsModel *model = [YSQKitsModel modelWithDictionary:dict];
            [self.rightListArr addObject:model];
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

#pragma mark ---UI

- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.942 green:0.945 blue:0.965 alpha:1.000];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)createCollectionView {
    XLPlainFlowLayout *layout = [[XLPlainFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    layout.itemSize = CGSizeMake((WIDTH - 30 - 100) / 2, 170);
    layout.naviHeight = 0;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(100, 64, WIDTH - 100, HEIGHT - 64) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[YSQKitsCell class] forCellWithReuseIdentifier:kitsCell];
    [self.collectionView registerClass:[YSQKitsReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:resuableView];
}

#pragma mark ---UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //设置cell选中状态的颜色
        UIView *backView = [[UIView alloc]initWithFrame:cell.frame];
        backView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = backView;
    }
    YSQKitsTypeModel *model = self.leftListArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = model.cnname;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = YSQNormalFont;
    return cell;
}

#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedIndex == indexPath.row) {
        return;
    }
    self.selectedIndex = indexPath.row;
    YSQKitsTypeModel *model = self.leftListArr[indexPath.row];
    self.ID = model.ID;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES animated:YES];
    [self loadRightListData];
 }

#pragma mark --UICollectionViewDataSource 

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    YSQKitsReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:resuableView forIndexPath:indexPath];
    YSQKitsModel *model = self.rightListArr[indexPath.section];
    view.title.text = model.name;
    return view;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(WIDTH, 40);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    YSQKitsModel *model = self.rightListArr[section];
    return model.guides.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.rightListArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQKitsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kitsCell forIndexPath:indexPath];
    YSQKitsModel *kitsModel = self.rightListArr[indexPath.section];
    YSQGuidesModel *model = kitsModel.guides[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

#pragma mark --UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQKitsModel *kitsModel = self.rightListArr[indexPath.section];
    YSQGuidesModel *model = kitsModel.guides[indexPath.row];
    YSQStrategyDetailController *detail = [[YSQStrategyDetailController alloc]init];
    detail.name = [NSString stringWithFormat:@"%@锦囊",model.guide_cnname];
    detail.ID = [NSNumber numberWithInteger:model.guide_id.integerValue];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
