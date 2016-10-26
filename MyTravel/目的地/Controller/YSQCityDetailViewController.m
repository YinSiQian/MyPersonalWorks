//
//  YSQCityDetailViewController.m
//  MyTravel
//
//  Created by ysq on 16/2/12.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQCityDetailViewController.h"
#import "YSQHotCity.h"
#import "YSQCountryDetail.h"
#import "YSQNewDiscount.h"
#import "YSQTableViewHeaderFooterView.h"
#import "YSQCityLocationCell.h"
#import "YSQDiscountCell.h"
#import "YSQFreedomCell.h"
#import "YSQHotelChooseView.h"
#import "YSQWebViewController.h"
#import "YSQHotelChooseView.h"
#import "YSQGreatestChooseController.h"
#import "YSQPlayViewController.h"
#import "YSQHotelController.h"
#import "YSQCommonHeaderCell.h"
#import "YSQFreedomController.h"
#import "YSQShowLocationViewController.h"

@interface YSQCityDetailViewController ()<YSQDiscountCellDelegate,YSQCityLocationCellDelegate,YSQCommonHeaderCellDelegate>
@property (nonatomic, strong) YSQCountryDetail *detailModel;
@property (nonatomic, assign) BOOL isZero;
@property (nonatomic, assign) CGFloat alpha;
@end

@implementation YSQCityDetailViewController

#pragma  mark ---View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.BarName;
    [self createNavItem];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.23 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self initNav];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [YSQHelp clearNavShadow:self isClear:NO];
}

- (void)initNav {
   [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(self.alpha)] forBarMetrics:UIBarMetricsDefault];
    //去掉透明导航栏时出现的底部分割线
    [YSQHelp clearNavShadow:self isClear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ---请求数据
- (void)loadData {
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_CITY_DETAIL_URL,self.ID] success:^(id responseObject) {
        NSDictionary *data = responseObject[@"data"];
        if (data.count == 0) {
            [YSQHelp networkActivityIndicatorVisible:NO toView:self.view] ;
            return ;
        }
        self.detailModel = [YSQCountryDetail ModelWithDict:data];
        if (self.detailModel.local_discount.count == 0) {
            self.isZero = YES;
        }
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        [self createTableView];
        [self createFooterView];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark ---UI构建

- (void)createNavItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"map"] style:UIBarButtonItemStylePlain target:self action:@selector(showMap)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)createFooterView {
    YSQHotelChooseView *chooseView = [YSQHotelChooseView hotelChooseView];
    chooseView.frame = CGRectMake(0, 0, WIDTH, 240);
    chooseView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = chooseView;    
}

#pragma mark --map

- (void)showMap {
    YSQShowLocationViewController *map = [[YSQShowLocationViewController alloc]init];
    map.city_id = self.ID;
    map.navTitle = [NSString stringWithFormat:@"%@地图",_BarName];
    [self.navigationController pushViewController:map animated:YES];
}

#pragma mark ---UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            if (self.isZero) return self.detailModel.New_discount.count;
            return self.detailModel.local_discount.count / 2;
            break;
        case 2:
            return self.detailModel.New_discount.count;
            break;
        default:
            return 0;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isZero && self.detailModel.New_discount.count == 0) {
        return 1;
    } else if (self.detailModel.New_discount.count == 0 || self.isZero) return 2;
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    } else if (indexPath.section == 1) {
        if (self.isZero) {
            return 80;
        }
        return 180;
    }
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 260 : 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        YSQTableViewHeaderFooterView *headerView = [YSQTableViewHeaderFooterView headerFooterView];
        headerView.frame = CGRectMake(0, 0, WIDTH, 260);
        headerView.isCity = YES;
        [headerView setDataWithModel:self.detailModel];
        return headerView;
    } else if (section == 1) {
        YSQCommonHeaderCell *common = [YSQCommonHeaderCell cellWithTableView:tableView];
        common.delegate = self;
        if (self.isZero) {
            common.name.text = @"超值自由行";
            common.isFreedom = YES;
        } else {
            common.name.text = @"精彩当地游";
        }
        return common;
    } else if (section == 2) {
        YSQCommonHeaderCell *common = [YSQCommonHeaderCell cellWithTableView:tableView];
        common.name.text = @"超值自由行";
        common.isFreedom = YES;
        common.delegate = self;
        return common;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YSQCityLocationCell *locationCell = [YSQCityLocationCell cellWithTableView:tableView];
        locationCell.delegate = self;
        return locationCell;
    } else if (indexPath.section == 1) {
        if (self.isZero) {
            YSQFreedomCell *freedom = [YSQFreedomCell cellWithTableView:tableView];
            YSQNewDiscount *newDiscount = self.detailModel.New_discount[indexPath.row];
            [freedom setDataWithModel:newDiscount];
            return freedom;
        }
        YSQDiscountCell *locationPlay = [YSQDiscountCell cellWithTableView:tableView];
        locationPlay.delegate = self;
        YSQNewDiscount *left_model = self.detailModel.local_discount[2 * indexPath.row];
        YSQNewDiscount *right_model = self.detailModel.local_discount[2 * indexPath.row + 1];
        [locationPlay setLocalDataWithLeftModel:left_model];
        [locationPlay setLocalDataWithRightModel:right_model];
        return locationPlay;
    } else {
        YSQFreedomCell *free = [YSQFreedomCell cellWithTableView:tableView];
        YSQNewDiscount *newDiscount = self.detailModel.New_discount[indexPath.row];
        [free setDataWithModel:newDiscount];
        return free;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
     if (self.isZero) {
        if (indexPath.section == 1 || indexPath.section == 2) {
            YSQWebViewController *web = [[YSQWebViewController alloc]init];
            YSQNewDiscount *newDiscount = self.detailModel.New_discount[indexPath.row];
            web.ID = newDiscount.ID;
            [self.navigationController pushViewController:web animated:YES];
        }
     } else {
         if (indexPath.section == 2) {
             YSQNewDiscount *newDiscount = self.detailModel.New_discount[indexPath.row];
             YSQWebViewController *web = [[YSQWebViewController alloc]init];
             web.ID = newDiscount.ID;
             [self.navigationController pushViewController:web animated:YES];
         }
     }
}

#pragma mark ---UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset=scrollView.contentOffset.y;
    self.alpha=1-((200-offset)/200);
    if (offset > 200) {
        self.alpha = 0.995792;
        [YSQHelp clearNavShadow:self isClear:NO];
    } else {
        [YSQHelp clearNavShadow:self isClear:YES];
    }
    if (self.alpha >= 0.1) {
        self.title = self.BarName;
    } else {
        self.title = @"";
    }
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(self.alpha)] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark --- MTDiscountCellDelegate

- (void)showDiscountDetailWithID:(NSNumber *)ID {
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    web.ID = ID;
    [self.navigationController pushViewController:web animated:YES];
}

#pragma mark -- YSQCommonHeaderCellDelegate

- (void)seeAllInfomationWithIsFreedom:(BOOL)isFreedom {
    YSQFreedomController *free = [[YSQFreedomController alloc]init];
    free.ID = self.ID;
    free.type = 2;
    if (isFreedom) {
        free.selectedIndex = 0;
    } else {
        free.selectedIndex = 1;
    }
    [self.navigationController pushViewController:free animated:YES];
}

#pragma mark -- YSQCityLocationCellDelegate 

- (void)goToLocalFeaturesWithIndex:(int)index {
    switch (index) {
        case 1:{
            YSQGreatestChooseController *choose = [[YSQGreatestChooseController alloc]init];
            choose.ID = self.ID;
            [self.navigationController pushViewController:choose animated:YES];
            break;
        }
        case 2: {
            YSQPlayViewController *play = [[YSQPlayViewController alloc]init];
            play.ID = self.ID;
            play.url = YSQ_CITY_PLAY_URL;
            play.name = @"游玩";
            play.isPlay = YES;
            [self.navigationController pushViewController:play animated:YES];
            break;
        }
        case 3: {
            YSQPlayViewController *play = [[YSQPlayViewController alloc]init];
            play.ID = self.ID;
            play.url = YSQ_CITY_FOOD_URL;
            play.name = @"美食";
            [self.navigationController pushViewController:play animated:YES];
            break;
        }
        case 4: {
            YSQHotelController *hotel = [[YSQHotelController alloc]init];
            hotel.ID = self.ID;
            hotel.name = [NSString stringWithFormat:@"%@酒店",self.BarName];
            [self.navigationController pushViewController:hotel animated:YES];
        }
        default:
            break;
    }
}


@end
