//
//  YSQPlayViewController.m
//  MyTravel
//
//  Created by ysq on 16/3/2.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQPlayViewController.h"
#import "YSQPlayModel.h"
#import "YSQPlayCell.h"
#import "YSQPlayDiscountModel.h"
#import "YSQLocationHeaderView.h"
#import "YSQSelectOverseasController.h"

@interface YSQPlayViewController ()<UITableViewDelegate,UITableViewDataSource,YSQPlayCellDelegate,YSQLocationHeaderViewDelegate>
@property (nonatomic, assign) int page;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation YSQPlayViewController

#pragma mark ---懒加载

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark ---view cycle life

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initNav];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = self.name;
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
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:self.url,self.page,self.ID] success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSDictionary *data = responseObject[@"data"];
        NSArray *entry = data[@"entry"];
        if (data.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
         for (NSDictionary *dict in entry) {
            YSQPlayModel *model = [YSQPlayModel modelWithDictionary:dict];
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
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
    }];
}

- (void)addUserCollectWithBeenstr:(NSString *)beenStr firstName:(NSString *)firstName gradescores:(NSNumber *)gradescores photoURL:(NSString *)url ID:(NSNumber *)ID{
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:63342/htdocs/YSQTravelAPI/userCollect.php?beenstr=%@&firstname=%@&photo=%@&gradescores=%@&id=%@",beenStr,firstName,url,gradescores,ID];
    [NetWorkManager getDataWithURL:urlString success:^(id responseObject) {
        if ([responseObject[@"success"] isEqual:@1]) {
            [SQProgressHUD showSuccessToView:self.view];
        } else {
            [SQProgressHUD showFailToView:self.view message:@"服务器错误" shake:NO];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)cancelUserCollect:(NSNumber *)ID {
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:63342/htdocs/YSQTravelAPI/removeCollect.php?id=%@",ID];
    [NetWorkManager getDataWithURL:urlString success:^(id responseObject) {
        if ([responseObject[@"success"] isEqual:@1]) {
            [SQProgressHUD showSuccessToView:self.view];
        } else {
            [SQProgressHUD showFailToView:self.view message:@"服务器错误" shake:NO];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark --UI构建

- (void)initNav {
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self createHeaderView];
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

- (void)createHeaderView {
    YSQLocationHeaderView *view = [[YSQLocationHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    view.delegate = self;
    view.title.text = self.isPlay ?   @"海外玩乐精选" : @"海外美食精选";
    view.title.textColor =self.isPlay ? [UIColor orangeColor] : [UIColor colorWithRed:0.459 green:0.000 blue:0.588 alpha:1.000];
    view.backgroundColor =self.isPlay ? [UIColor colorWithRed:1.000 green:0.794 blue:0.000 alpha:0.5] : [UIColor colorWithRed:0.500 green:0.000 blue:0.500 alpha:0.500];
    view.go.textColor =self.isPlay ? [UIColor orangeColor] : [UIColor purpleColor];
    self.tableView.tableHeaderView = view;
}

#pragma mark ---UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSQPlayModel *playModel = self.dataArray[indexPath.row];
    YSQPlayCell *play = [YSQPlayCell cellWithTableView:tableView];
    play.delegate = self;
    [play setDataWithModel:playModel];
    return play;
}

#pragma mark ---YSQPlayCellDelegate 

- (void)loveWithIndex:(NSInteger)index isLove:(BOOL)isLove{
    YSQPlayModel *model = self.dataArray[index];
    NSString *url = [NSString stringWithFormat:@"%@",model.photo];
    if (isLove) {
       [self addUserCollectWithBeenstr:[model.beenstr stringByURLEncode] firstName:[model.firstname stringByURLEncode] gradescores:model.gradescores photoURL:url ID:model.ID];
    } else {
        [self cancelUserCollect:model.ID];
    }
}

#pragma mark ---YSQLocationHeaderViewDelegate

- (void)seeBoardChoose {
    YSQSelectOverseasController *oversea = [[YSQSelectOverseasController alloc]init];
    oversea.title = self.isPlay ?   @"海外玩乐精选" : @"海外美食精选";
    oversea.ID = self.ID;
    oversea.type = self.isPlay ? 2 : 1;
    [self.navigationController pushViewController:oversea animated:YES];
}

@end
