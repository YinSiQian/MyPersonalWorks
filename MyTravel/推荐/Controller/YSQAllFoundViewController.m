//
//  YSQAllFoundViewController.m
//  MyTravel
//
//  Created by ysq on 16/3/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQAllFoundViewController.h"
#import "YSQFoundCell.h"
#import "YSQNewDiscount.h"
#import "YSQWebViewController.h"

@interface YSQAllFoundViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int page;
@end

@implementation YSQAllFoundViewController

#pragma mark ---懒加载

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark ---view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
    self.title = @"发现美丽";
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
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_ALLFOUND_URL,self.page] success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSArray *data = responseObject[@"data"];
        if (data.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        for (NSDictionary *dict in data) {
            YSQNewDiscount *model = [YSQNewDiscount ModelWithDict:dict];
            [self.dataArray addObject:model];
        }
        [self.tableView.mj_footer endRefreshing];
        self.page ++;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

#pragma mark ---UI
- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
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
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 290;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSQFoundCell *cell = [YSQFoundCell cellWithTableView:tableView];
    YSQNewDiscount *model = self.dataArray[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    YSQNewDiscount *model = self.dataArray[indexPath.row];
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    web.url = model.url;
    [self.navigationController pushViewController:web animated:YES];
}

@end
