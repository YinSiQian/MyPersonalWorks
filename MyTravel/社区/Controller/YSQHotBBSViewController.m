//
//  YSQHotBBSViewController.m
//  MyTravel
//
//  Created by ysq on 16/6/18.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotBBSViewController.h"
#import "YSQHotBBSModel.h"
#import "YSQHotBBSCell.h"
#import "YSQHotBBSOtherCell.h"
#import "YSQWebViewController.h"

@interface YSQHotBBSViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int page;

@end

@implementation YSQHotBBSViewController

#pragma mark --懒加载

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark -- View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self loadData];
    [self createTableView];
    [self createRefreshView];
}

#pragma mark --数据处理

- (void)loadData {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_HOT_BBS_URL,self.page] success:^(id responseObject) {
        NSArray *arr = responseObject[@"data"];
        if (arr.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        for (NSDictionary *dict in arr) {
            YSQHotBBSModel *model = [YSQHotBBSModel modelWithDictionary:dict];
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

#pragma mark -- UI

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


- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark --UITableViewDelegate&UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSQHotBBSModel *model = self.dataArray[indexPath.row];
    NSString *title = model.title;
    if (model.is_best.boolValue || model.is_hot.boolValue) {
        title = [NSString stringWithFormat:@"%@  精华",model.title];
    }
    CGSize titleSize = [title sizeForFont:[UIFont boldSystemFontOfSize:15] size:CGSizeMake(WIDTH - 65 - 25, 40) mode:NSLineBreakByWordWrapping];
    if (model.bigpic_arr.count == 0 ) {
        return titleSize.height > 30 ? 120 : 100;
    } else {
        return titleSize.height > 30 ? 220 : 200;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSQHotBBSModel *model = self.dataArray[indexPath.row];
//    BOOL haveImg = model.bigpic_arr.count != 0 ? YES : NO;
    YSQHotBBSCell *cell = [YSQHotBBSCell cellWithTableView:tableView];
    [cell setDataWithModel:model];
    return cell;

//    if (haveImg) {
//        YSQHotBBSCell *cell = [YSQHotBBSCell cellWithTableView:tableView];
//        [cell setDataWithModel:model];
//        return cell;
//    } else {
//        YSQHotBBSOtherCell *cell = [YSQHotBBSOtherCell cellWithTableView:tableView];
//        [cell setDataWithModel:model];
//        return cell;
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    YSQHotBBSModel *model = self.dataArray[indexPath.row];
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    web.url = model.appview_url;
    [self.navigationController pushViewController:web animated:YES];
}


@end
