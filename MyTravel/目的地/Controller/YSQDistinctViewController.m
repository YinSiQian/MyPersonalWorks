//
//  YSQDistinctViewController.m
//  MyTravel
//
//  Created by ysq on 16/1/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQDistinctViewController.h"
#import "YSQWebViewController.h"
#import "YSQCountryDetail.h"
#import "YSQHotCity.h"
#import "YSQNewDiscount.h"
#import "YSQFoundTypeCell.h"
#import "YSQCommonHeaderCell.h"
#import "YSQFreedomCell.h"
#import "YSQNewDiscount.h"
#import "YSQTableViewHeaderFooterView.h"
#import "YSQCityDetailViewController.h"
#import "YSQAllCityController.h"
#import "YSQFreedomController.h"

@interface YSQDistinctViewController ()<YSQFoundTypeCellHotDelegate,YSQCommonHeaderCellDelegate>
@property (nonatomic, strong) YSQCountryDetail *detailModel;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, strong) UIImage *navImage;
@end

@implementation YSQDistinctViewController

#pragma mark ---view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.alpha = 0.f;
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self initNav];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark --UI

- (void)initNav {
     [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(self.alpha)] forBarMetrics:UIBarMetricsDefault];
    self.navImage = [[UIImage alloc]init];
    self.navImage = [YSQHelp imageWithBgColor:YSQWhiteColor(0)];
    //去掉透明导航栏时出现的底部分割线
    [YSQHelp clearNavShadow:self isClear:YES];
}

- (void)createHeaderView {
    YSQTableViewHeaderFooterView *headerView = [YSQTableViewHeaderFooterView headerFooterView];
    headerView.tag = 10;
    headerView.frame = CGRectMake(0, 0, WIDTH, 260);
    [headerView setDataWithModel:self.detailModel];
    //[self.tableView addSubview:headerView];
    self.tableView.tableHeaderView = headerView;
   // self.tableView.contentInset = UIEdgeInsetsMake(260, 0, 0, 0);

}

#pragma mark --网络请求
- (void)loadData {
    NSString *url = [NSString stringWithFormat:MT_COUNTRY_DETAIL_URL,self.ID];
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [NetWorkManager getDataWithURL:url success:^(id responseObject) {
        NSDictionary *data = responseObject[@"data"];
        if (data.count == 0) {
            [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
            return ;
        }
        self.detailModel = [YSQCountryDetail ModelWithDict:data];
        [SQProgressHUD hideHUDToView:self.view animated:YES];
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        [self createTableView];
    } failure:^(NSError *error) {
        [SQProgressHUD hideHUDToView:self.view animated:YES];
        NSLog(@"%@",error);
    }];
}

#pragma mark ----UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.detailModel.New_discount.count == 0 ? 1 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.detailModel.hot_city.count / 2 +1;
            break;
        case 1:
             return self.detailModel.New_discount.count +1;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row != 0) {
            return 100;
        }
    } else if (indexPath.row != 0) {
            return 80;
        }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 260 : 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        YSQTableViewHeaderFooterView *headerView = [YSQTableViewHeaderFooterView headerFooterView];
        headerView.frame = CGRectMake(0, 0, WIDTH, 260);
        [headerView setDataWithModel:self.detailModel];
        return headerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            YSQCommonHeaderCell *headerCell = [YSQCommonHeaderCell cellWithTableView:tableView];
            headerCell.delegate = self;
            headerCell.name.text = [NSString stringWithFormat:@"%@城市",self.name];
            headerCell.isFreedom = NO;
            return headerCell;
        }
        YSQFoundTypeCell *typeCell = [YSQFoundTypeCell cellWithTableView:tableView];
        typeCell.hotDelegate = self;
        YSQHotCity *left_hotModel = self.detailModel.hot_city[2*indexPath.row - 2];
        YSQHotCity *right_hotModel = self.detailModel.hot_city[2*indexPath.row - 1];
        [typeCell setDataWithLeftModel:left_hotModel];
        [typeCell setDataWithRightModel:right_hotModel];
        return typeCell;
    } else {
        if (indexPath.row == 0) {
            YSQCommonHeaderCell *headerCell = [YSQCommonHeaderCell cellWithTableView:tableView];
            headerCell.delegate = self;
            headerCell.name.text = @"超值自由行";
            headerCell.isFreedom = YES;
            return headerCell;
        }
        YSQFreedomCell *freedom = [YSQFreedomCell cellWithTableView:tableView];
        YSQNewDiscount *newDiscount = self.detailModel.New_discount[indexPath.row - 1];
        [freedom setDataWithModel:newDiscount];
        return freedom;
      }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row != 0) {
            YSQNewDiscount *model = self.detailModel.New_discount[indexPath.row - 1];
            YSQWebViewController *webView = [[YSQWebViewController alloc]init];
            webView.ID = [NSNumber numberWithInt:model.ID.intValue];
            [self.navigationController pushViewController:webView animated:YES];
        }
    }
}

#pragma mark ---UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset=scrollView.contentOffset.y;
    NSLog(@"%f",offset);
    self.alpha=1-((200-offset)/200);
    if (offset > 200) {
        self.alpha = 0.995792;
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(self.alpha)] forBarMetrics:UIBarMetricsDefault];
    }
    if (self.alpha >= 0.1) {
        self.title = self.name;
    } else {
        self.title = @"";
    }
   }


#pragma mark ---MTMTFoundTypeCellHotDelegate

- (void)showCityDetailWithModel:(YSQHotCity *)model {
    YSQCityDetailViewController *cityDetail = [[YSQCityDetailViewController alloc]init];
    cityDetail.ID = model.hot_id;
    cityDetail.BarName = model.cnname;
    [self.navigationController pushViewController:cityDetail animated:YES];
}

#pragma mark ---YSQCommonHeaderCellDelegate
- (void)seeAllInfomationWithIsFreedom:(BOOL)isFreedom {
    if (isFreedom) {
        YSQFreedomController *free = [[YSQFreedomController alloc]init];
        free.ID = self.ID;
        free.type = 1;
        free.selectedIndex = 0;
        [self.navigationController pushViewController:free animated:YES];
    } else {
        YSQAllCityController *allCity = [[YSQAllCityController alloc]init];
        allCity.ID = self.ID;
        [self.navigationController pushViewController:allCity animated:YES];
    }
}

@end
