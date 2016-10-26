//
//  RecomendViewController.m
//  MyTravel
//
//  Created by ysq on 16/1/3.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "RecomendViewController.h"
#import "YSQRecommendModel.h"
#import "YSQSubjectModel.h"
#import "YSQSlideModel.h"
#import "YSQHotNotesCell.h"
#import "YSQHotNotesModel.h"
#import "YSQDiscountModel.h"
#import "YSQBannerCell.h"
#import "YSQFoundCell.h"
#import "YSQFoundTypeCell.h"
#import "YSQDiscountCell.h"
#import "YSQWebViewController.h"
#import "YSQTitleHeaderView.h"
#import "YSQFooterView.h"
#import "YSQAllFoundViewController.h"
#import "YSQAllDiscountViewController.h"
#import "YSQStrategyViewController.h"
#import "YSQAddressViewController.h"
#import "YSQReadBookViewController.h"
#import "FMDB.h"

@interface RecomendViewController ()<UITableViewDelegate,UITableViewDataSource,YSQBannerCellDelegate,YSQFoundTypeCellDelegate,YSQDiscountCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) YSQRecommendModel *model;
@property (nonatomic, assign) int page;
@end

@implementation RecomendViewController

//懒加载
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)hotArray {
    if (!_hotArray) {
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}

#pragma mark --- view life cycle 

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQGreenColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.910 green:0.902 blue:0.914 alpha:1.000];
    self.page = 1;
    [self createTableView];
    [self loadData];
    [self createRefreshView];
}

#pragma mark ---UI
- (void)createRefreshView {
    __weak typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *foot = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadHotDataWithPage:weakSelf.page];
    }];
    foot.automaticallyRefresh = YES;
    self.tableView.mj_footer =foot;
}

- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 54, WIDTH, HEIGHT - 54) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark ---网络请求

- (void)loadHotDataWithPage:(int)page {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:MT_HOTNOTES_URL,page] success:^(id responseObject) {
        NSArray *data = [responseObject objectForKey:@"data"];
        if (data.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        for (NSDictionary *dict in data) {
            YSQHotNotesModel *model = [YSQHotNotesModel ModelWithDict:dict];
            [self.hotArray addObject:model];
        }
        self.page ++;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadData {
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [NetWorkManager getDataWithURL:MT_FOUND_URL success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
         NSDictionary *data = [responseObject objectForKey:@"data"];
        self.dataArray = @[[YSQRecommendModel ModelWithDict:data]];

        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

#pragma mark ---数据缓存

- (void)cacheTheData {
    NSString *dbPath = [YSQHelp getDBPath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS slide(photo text NOT NULL, url text NOT NULL);"];
        BOOL result1 = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS discount(photo text NOT NULL, title text NOT NULL, price text NOT NULL, priceoff text NOT NULL,end_date text NOT NULL,id integer NOT NULL);"];
        BOOL result2 = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS subject(photo text NOT NULL, url text NOT NULL,title text NOT NULL);"];
        [db executeUpdate:@"DELETE FROM slide"];
        [db executeUpdate:@"DELETE FROM discount"];
        [db executeUpdate:@"DELETE FROM subject"];

        if (result) {
            //插入数据
            NSString *sql = @"insert into slide (photo, url) values (?,?)";
            for (int i = 0; i < self.model.slide.count; i++) {
                YSQSlideModel *model = self.model.slide[i];
                [db executeUpdate:sql,model.photo,model.url];
            }
        }
        if (result1) {
            NSString *sql = @"insert into discount (photo, title,price,priceoff,end_date,id) values (?,?,?,?,?,?)";
            for (int i = 0; i < self.model.discount.count; i++) {
                YSQDiscountModel *model = self.model.discount[i];
                [db executeUpdate:sql,model.photo,model.title,model.price,model.priceoff,model.end_date,model.ID];
            }
        }
        if (result2) {
            NSString *sql = @"insert into subject (photo, url, title) values (?,?,?)";
            for (int i = 0; i < self.model.subject.count; i++) {
                YSQSubjectModel *model = self.model.subject[i];
             BOOL resu = [db executeUpdate:sql,model.photo,model.url,model.title];
                if (!resu) {
                    NSLog(@"%@",db.lastErrorMessage);
                }
            }
            //[db executeUpdate:sql,[self.model.discount_subject.firstObject objectForKey:@"photo"],@"",@""];
        }
    }
    [db close];
}

#pragma mark ----UITableViewDataSourceDelegate----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 350;
    }
    if (indexPath.section == 1) {
        return 150;
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 150;
        }
    }
    if (indexPath.section == 3) {
        return 100;
    }
    return 180;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 30;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1 || section == 2) {
        return 40;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YSQTitleHeaderView *header = [[YSQTitleHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    if (section == 1) {
        header.title.text = @"发现下一站";
        return header;
    } else if (section == 2) {
        header.title.text = @"抢特价折扣";
        return header;
    } else if (section == 3) {
        header.title.text = @"热门游记";
        return header;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    YSQFooterView *footerView = [[YSQFooterView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    footerView.backgroundColor = [UIColor whiteColor];
    if (section == 1) {
        footerView.type = SeeMoreTopic;
    } else if (section == 2) {
        footerView.type = SeeMoreDiscount;
    }
    [footerView setSeeMoreTopic:^(SeeMoreType type) {
        if (type == SeeMoreTopic) {
            YSQAllFoundViewController *all = [[YSQAllFoundViewController alloc]init];
            [self.navigationController pushViewController:all animated:YES];
        } else {
            YSQAllDiscountViewController *discount = [[YSQAllDiscountViewController alloc]init];
            [self.navigationController pushViewController:discount animated:YES];
        }
    }];
    if (section == 1 || section == 2) {
        return footerView;
    }
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count>0) self.model = self.dataArray[0];
    if (section == 0) return 1;
    if (section == 1) return 2;
    if (section == 2) return self.model.discount.count / 2 + 1;
    return self.hotArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.hotArray.count>0) return 4;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count>0) {
        self.model = self.dataArray[0];
    }
    if (indexPath.section == 0) {
        YSQBannerCell *bannerCell = [YSQBannerCell cellWithTableView:tableView];
        bannerCell.delegate = self;
        [bannerCell setAutoScrollViewWithModel:self.model];
        return bannerCell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            YSQFoundCell *foundCell = [YSQFoundCell cellWithTableView:tableView];
            [foundCell.image sd_setImageWithURL:[NSURL URLWithString:[self.model.subject.firstObject photo]]];
            return foundCell;
        } else {
            YSQFoundTypeCell *typeCell = [YSQFoundTypeCell cellWithTableView:tableView];
            typeCell.delegate = self;
            if (self.model.subject.count != 0) {
                [typeCell setDataWithArray:self.model.subject];
            }
            return typeCell;
        }
    } else if (indexPath.section ==2) {
        if (indexPath.row == 0) {
            YSQFoundCell *foundCell = [YSQFoundCell cellWithTableView:tableView];
            [foundCell.image sd_setImageWithURL:[NSURL URLWithString:[[self.model discount_subject][0]
                                                                      objectForKey:@"photo"]]];
            return foundCell;
        } else {
            YSQDiscountCell *discountCell = [YSQDiscountCell cellWithTableView:tableView];
            YSQDiscountModel *leftdismodel = [self.model discount][2 * indexPath.row -1];
            YSQDiscountModel *rightmodel = [self.model discount][2 * indexPath.row - 2];
            [discountCell setDataWithLeftModel:leftdismodel];
            [discountCell setDataWithRightModel:rightmodel];
            discountCell.delegate = self;
            return discountCell;
        }
    } else {
        static NSString *reuseIdentifier = @"MTHotNotesCell";
        YSQHotNotesCell *hotCell =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!hotCell) {
            hotCell = [[YSQHotNotesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        YSQHotNotesModel *model = self.hotArray[indexPath.row];
        [hotCell setDataWithModel:model];
        return hotCell;
    }
}
#pragma mark ----UITableViewDelegate---- 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
             YSQWebViewController *web = [[YSQWebViewController alloc]init];
            YSQSubjectModel *model = self.model.subject.firstObject;
            web.url = model.url;
             [self.navigationController pushViewController:web animated:YES];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            YSQWebViewController *web = [[YSQWebViewController alloc]init];
            web.url =[[self.model discount_subject][0] objectForKey:@"url"];
            [self.navigationController pushViewController:web animated:YES];
        }
    }
    if (indexPath.section == 3) {
        YSQHotNotesModel *model = self.hotArray[indexPath.row];
        YSQWebViewController *web = [[YSQWebViewController alloc]init];
        web.url = model.view_url;
        [self.navigationController pushViewController:web animated:YES];
    }
}

#pragma mark ----MTBannerCellDelegate----

- (void)goToBannerDetailWithURL:(NSString *)url {
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    web.url = url;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)seeTravelService:(YSQTraveServiceType)service {
    switch (service) {
        case YSQTravelHotelService: {
        
            break;
        }
        case YSQTravelDiscountService: {
            YSQAllDiscountViewController *discount = [[YSQAllDiscountViewController alloc]init];
            [self.navigationController pushViewController:discount animated:YES];
            break;
        }
        case YSQTravelLocationService: {
            YSQAddressViewController *address = [[YSQAddressViewController alloc]init];
            [self.navigationController pushViewController:address animated:YES];
            break;
        }
        case YSQTravelStrategyService: {
            YSQStrategyViewController *strategy = [[YSQStrategyViewController alloc]init];
            [self.navigationController pushViewController:strategy animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark ----MTFoundTypeCellDelegate----

- (void)showDetailWithURL:(NSString *)url {
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    web.url = url;
    [self.navigationController pushViewController:web animated:YES];
}

#pragma mark ----MTDiscountCellDelegate----

- (void)showDiscountDetailWithID:(NSNumber *)ID {
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    web.ID = ID;
    [self.navigationController pushViewController:web animated:YES];
}


@end
