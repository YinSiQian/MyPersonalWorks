//
//  YSQGreatestChooseController.m
//  MyTravel
//
//  Created by ysq on 16/3/1.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQGreatestChooseController.h"
#import "YSQGreatestSelectModel.h"
#import "YSQGreatestChooseCell.h"

@interface YSQGreatestChooseController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) int page;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL addRefresh;
@end

@implementation YSQGreatestChooseController

#pragma mark ---懒加载 

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark ---view cycle life

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    [self initNav];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"精选";
    self.page = 1;
    [self createTableView];
    [self createRefreshView];
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --网络请求

- (void)loadData {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_CITY_CHOOSE_URL,self.ID,self.page] success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSArray *data = responseObject[@"data"];
        if (data.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        for (NSDictionary *dict in data) {
            YSQGreatestSelectModel *model = [YSQGreatestSelectModel modelWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        self.page++;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

#pragma mark --UI构建

- (void)initNav {
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}


- (void)createRefreshView {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.tableView.mj_footer = footer;
    footer.automaticallyRefresh = YES;
    footer.automaticallyHidden = YES;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self.dataArray removeAllObjects];
        [self loadData];
    }];
    self.tableView.mj_header = header;
    self.addRefresh = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSQGreatestSelectModel *model = self.dataArray[indexPath.row];
    YSQGreatestChooseCell *chooseCell = [YSQGreatestChooseCell cellWithTableView:tableView];
    [chooseCell setDataWithModel:model];
    return chooseCell;
}

@end
