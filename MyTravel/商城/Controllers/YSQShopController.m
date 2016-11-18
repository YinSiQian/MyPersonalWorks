//
//  YSQShopController.m
//  MyTravel
//
//  Created by ysq on 16/8/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQShopController.h"
#import "YSQMallTopCell.h"
#import "YSQHotAreaCell.h"
#import "YSQMallShopModel.h"
#import "YSQMarketCell.h"
#import "YSQWebViewController.h"
#import "YSQMallDiscountHeaderCell.h"
#import "YSQMallDiscountCell.h"
#import "YSQMallGoodsSuperCell.h"
#import "YSQLiveListControllerController.h"
#import "YSQShowYourselfController.h"

@interface YSQShopController ()<YSQMarketCellDelegate,YSQHotAreaCellDelegate>
@property (nonatomic, strong) YSQMallShopModel *mallModel;
@end

@implementation YSQShopController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQGreenColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startLive {
    YSQShowYourselfController *show = [[YSQShowYourselfController alloc]init];
    [self presentViewController:show animated:YES completion:nil];
}

- (void)live {
    YSQLiveListControllerController *list = [[YSQLiveListControllerController alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}

#pragma mark --UI 

- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"看直播" style:UIBarButtonItemStylePlain target:self action:@selector(live)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"开始直播" style:UIBarButtonItemStylePlain target:self action:@selector(startLive)];
    left.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = left;
}

#pragma mark --网络请求

- (void)loadData {
    [NetWorkManager getDataWithURL:YSQ_MALL_URL success:^(id responseObject) {
        NSDictionary *data = responseObject[@"data"];
        self.mallModel = [YSQMallShopModel modelWithDictionary:data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.mallModel.hot_area.count;
    }
    if (section == 3 || section == 4) {
        return 4;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 5) {
        return .1;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200;
    } else if (indexPath.section == 1) {
        return 150;
    } else if (indexPath.section == 2) {
        return 420;
    } else if (indexPath.section ==  3 || indexPath.section == 4) {
        if (indexPath.row == 0) {
            return 160;
        }
        return 100;
    } else {
        return self.mallModel.hot_goods.count / 2 * 180 + 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YSQMallTopCell *cell = [YSQMallTopCell cellWithTableView:tableView];
        return cell;
    } else if (indexPath.section == 1) {
        YSQMarketCell *cell = [YSQMarketCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.modelArr = self.mallModel.market_topic;
        return cell;
    } else if (indexPath.section == 2){
        YSQHotAreaCell *cell = [YSQHotAreaCell cellWithTableView:tableView];
        YSQHotAreaModel *model = self.mallModel.hot_area[indexPath.row];
        cell.delegate = self;
        [cell setDataModel:model];
        return cell;
    } else if (indexPath.section == 3 || indexPath.section == 4) {
        YSQShopDiscountModel *model = indexPath.section == 3 ? self.mallModel.discount_topic.firstObject : self.mallModel.discount_topic.lastObject;
        if (indexPath.row == 0) {
            YSQMallDiscountHeaderCell *cell = [YSQMallDiscountHeaderCell cellWithTableView:tableView];
            [cell setTopic:model.topic];
            return cell;
        } else {
            YSQMallDiscountCell *cell = [YSQMallDiscountCell cellWithTableView:tableView];
            YSQMallListModel *listModel = model.list[indexPath.row - 1];
            [cell setDataWithModel:listModel];
            return cell;
        }
    } else {
        YSQMallGoodsSuperCell *cell = [YSQMallGoodsSuperCell cellWithTableView:tableView];
        cell.modelArr = self.mallModel.hot_goods;
        return cell;
    }
}

#pragma mark --YSQMarketCellDelegate

- (void)seeRecommend:(NSString *)url {
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    web.url = url;
    [self.navigationController pushViewController:web animated:YES];
}

#pragma mark --YSQHotAreaCellDelegate

- (void)seeAreaTopic:(NSString *)type {
    
}

- (void)seeHotCountry:(NSString *)countryID {
    
}

- (void)seeDiscountDetail:(NSString *)ID {
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    web.ID = [NSNumber numberWithInteger:ID.integerValue];
    [self.navigationController pushViewController:web animated:YES];
}

@end
