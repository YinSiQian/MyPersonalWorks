//
//  YSQFreeChildViewController.m
//  MyTravel
//
//  Created by ysq on 16/3/24.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQFreeChildViewController.h"
#import "YSQFreedomCell.h"
#import "YSQNewDiscount.h"
#import "YSQWebViewController.h"

@interface YSQFreeChildViewController ()

@property (nonatomic, assign) int page;

@end

@implementation YSQFreeChildViewController

#pragma mark --懒加载

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self createRefreshView];
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [self loadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark --网络请求
- (void)loadData {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_FREEWALK_URL,self.type,self.ID,self.page,self.productType,self.datatype] success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSDictionary *dict = responseObject[@"data"];
        NSArray *data = dict[@"list"];
        if (data.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        for (NSDictionary *dict in data) {
            YSQNewDiscount *model = [YSQNewDiscount ModelWithDict:dict];
            [self.dataArray addObject:model];
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

#pragma mark --UI 

- (void)createRefreshView {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.tableView.mj_footer = footer;
    footer.automaticallyRefresh = YES;
    footer.automaticallyHidden = YES;
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSQFreedomCell *cell = [YSQFreedomCell cellWithTableView:tableView];
    YSQNewDiscount *model = self.dataArray[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YSQNewDiscount *model = self.dataArray[indexPath.row];
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    web.ID = model.ID;
    [self.navigationController pushViewController:web animated:YES];
}

@end
