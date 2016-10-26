//
//  YSQHotelController.m
//  MyTravel
//
//  Created by ysq on 16/3/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotelController.h"
#import "YSQCityHotelModel.h"
#import "YSQHotelCell.h"


@interface YSQHotelController ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) YSQHotelModel *hotelModel;
@property (nonatomic, assign) int page;
@end

@implementation YSQHotelController


#pragma mark --懒加载

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark --View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.name;
    self.page = 1;
    [self initNav];
    [self createRefreshView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ---网络请求

- (void)loadData {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_CITY_HOTEL_URL,self.ID,self.page] success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSDictionary *data = responseObject[@"data"];
        self.hotelModel = [YSQHotelModel modelWithDictionary:data];
        if (self.hotelModel.hotel.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [self.dataArray addObjectsFromArray:self.hotelModel.hotel];
        self.page ++;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

#pragma mark ---UI 

- (void)initNav {
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
}

- (void)createRefreshView {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.tableView.mj_footer = footer;
    footer.automaticallyRefresh = YES;
    footer.automaticallyHidden = YES;
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
    YSQHotelCell *cell = [YSQHotelCell cellWithTableView:tableView];
    YSQCityHotelModel *model = self.dataArray[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}



@end
