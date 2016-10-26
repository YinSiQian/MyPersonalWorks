//
//  YSQMoreCategoriesViewController.m
//  MyTravel
//
//  Created by ysq on 16/6/28.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQMoreCategoriesViewController.h"
#import "YSQCategoryModel.h"

@interface YSQMoreCategoriesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation YSQMoreCategoriesViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark --View life cycle 

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQGreenColor(0.9956)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多分类";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavItem];
    self.selectedIndex = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- init

- (void)createNavItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];
    item.tintColor = [UIColor whiteColor];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)returnAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)createTableView {
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 100, HEIGHT - 64) style:UITableViewStylePlain];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.tableFooterView = [UIView new];
    [_listTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.view addSubview:_listTableView];
    
    _contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(100, 64, WIDTH - 100, HEIGHT - 64) style:UITableViewStylePlain];
    _contentTableView.delegate = self;
    _contentTableView.backgroundColor = [UIColor colorWithRed:0.905 green:0.911 blue:0.915 alpha:1.000];
    _contentTableView.dataSource = self;
    _contentTableView.tableFooterView = [UIView new];
    [_contentTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.view addSubview:_contentTableView];
}

#pragma mark --数据请求

- (void)loadData {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_CITY_CATEGORY_URL,_city_id] success:^(id responseObject) {
        NSArray *arr = responseObject[@"data"];
        for (NSDictionary *dict in arr) {
            YSQCategoryModel *model = [YSQCategoryModel modelWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        [self createTableView];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark --UITableViewDelegate &UITableViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _listTableView) {
        return self.dataArray.count;
    }
    YSQCategoryModel *model = self.dataArray[_selectedIndex];
    return model.children.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _listTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"list"];
            cell.backgroundColor = [UIColor whiteColor];
        }
        YSQCategoryModel *model = self.dataArray[indexPath.row];
        cell.textLabel.text = model.category;
        cell.textLabel.font = YSQNormalFont;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"content"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"content"];
            cell.backgroundColor = [UIColor colorWithRed:0.905 green:0.911 blue:0.915 alpha:1.000];
        }
        YSQCategoryModel *model = self.dataArray[_selectedIndex];
        YSQChildrenModel *children = model.children[indexPath.row];
        cell.textLabel.text = children.name;
        cell.textLabel.textColor = YSQBlack;
        cell.textLabel.font = YSQNormalFont;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _listTableView) {
        _selectedIndex = indexPath.row;
        [self handleSelectedCell:_listTableView count:self.dataArray.count index:_selectedIndex];
        [_contentTableView reloadData];
    } else {
        YSQCategoryModel *model = self.dataArray[_selectedIndex];
        YSQChildrenModel *children = model.children[indexPath.row];
        [self handleSelectedCell:_contentTableView count:model.children.count index:indexPath.row];
        if (self.callBack) {
            self.callBack(model.ID,children.ID);
        }
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)handleSelectedCell:(UITableView *)tableView count:(NSInteger)count index:(NSInteger )index{
    for (int i = 0; i < count; i++) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.textLabel.textColor = [UIColor blackColor];
        if (i == index) {
            cell.textLabel.textColor = YSQGreenColor(1);
        } else {
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }

}


@end
