//
//  YSQSelectOverseasController.m
//  MyTravel
//
//  Created by ysq on 16/4/13.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQSelectOverseasController.h"
#import "YSQFreedomCell.h"
#import "YSQNewDiscount.h"
#import "YSQWebViewController.h"

@interface YSQSelectOverseasController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int page;
@end

@implementation YSQSelectOverseasController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark -- View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page = 1;
    [self createRefreshView];
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 网络

- (void)loadData {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_OVERSEA_SELECT_URL,self.ID,self.page,self.type] success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSArray *data = responseObject[@"data"];
        if (data.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (self.page == 1) {
            [self.tableView.mj_header endRefreshing];
            [self.dataArray removeAllObjects];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        for (NSDictionary *dict in data) {
            YSQNewDiscount *model = [YSQNewDiscount ModelWithDict:dict];
            [self.dataArray addObject:model];
        }
        self.page ++;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

#pragma mark -- 刷新

- (void)createRefreshView {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.tableView.mj_footer = footer;
    footer.automaticallyRefresh = YES;
    footer.automaticallyHidden = YES;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self loadData];
    }];
    self.tableView.mj_header = header;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSQFreedomCell *cell = [YSQFreedomCell cellWithTableView:tableView];
    YSQNewDiscount *model = self.dataArray[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

#pragma mark -- TableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YSQNewDiscount *model = self.dataArray[indexPath.row];
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    web.ID = model.ID;
    [self.navigationController pushViewController:web animated:YES];
}

@end
