//
//  YSQSearchFriendsViewController.m
//  MyTravel
//
//  Created by ysq on 16/6/18.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQSearchFriendsViewController.h"
#import "YSQCompanyModel.h"
#import "YSQSearchFriendsCellTableViewCell.h"
#import "YSQWebViewController.h"

@interface YSQSearchFriendsViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int page;
@end

@implementation YSQSearchFriendsViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, 64, WIDTH, HEIGHT);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page = 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
    });
    [self createRefreshView];
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
}


#pragma mark --数据处理

- (void)loadData {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_SEARCH_FRIEND_URL,self.page] success:^(id responseObject) {
        NSArray *arr = responseObject[@"data"];
        if (arr.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        for (NSDictionary *dict in arr) {
            YSQCompanyModel *model = [YSQCompanyModel modelWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        if (self.page == 1) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        self.page++;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSQSearchFriendsCellTableViewCell *cell = [YSQSearchFriendsCellTableViewCell cellWithTableView:tableView];
    YSQCompanyModel *model = self.dataArray[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

#pragma mark -- TableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    YSQCompanyModel *model = self.dataArray[indexPath.row];
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    web.url = model.appview_url;
    [self.navigationController pushViewController:web animated:YES];
}

@end
