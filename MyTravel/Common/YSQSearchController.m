//
//  YSQSearchController.m
//  MyTravel
//
//  Created by ysq on 16/8/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQSearchController.h"
#import "YSQTagView.h"
#import "YSQSearchHeadView.h"
#import "YSQSearchResultModel.h"
#import "YSQSearchCell.h"
#import "YSQWebViewController.h"

@interface YSQSearchController ()<UISearchBarDelegate,YSQTagViewDelegate>

@property (nonatomic, strong) UISearchBar *search;

@property (nonatomic, assign) BOOL haveHistoryNote;
@property (nonatomic, assign) BOOL isSearch;

@property (nonatomic, strong) NSMutableArray *historyArr;
@property (nonatomic, copy) NSArray *hotSearchKeys;
@property (nonatomic, strong) NSMutableArray *searchModelArr;
@property (nonatomic, strong) NSMutableArray *cacheHeightArr;
@property (nonatomic, assign) int page;
@property (nonatomic, copy) NSString *searchKey;


@end

@implementation YSQSearchController

- (NSMutableArray *)historyArr {
    if (!_historyArr) {
        _historyArr = [NSMutableArray array];
    }
    return _historyArr;
    
}

- (NSMutableArray *)searchModelArr {
    if (!_searchModelArr) {
        _searchModelArr = [NSMutableArray array];
    }
    return _searchModelArr;
}

- (NSMutableArray *)cacheHeightArr {
    if (!_cacheHeightArr) {
        _cacheHeightArr = [NSMutableArray array];
    }
    return _cacheHeightArr;
}

#pragma mark --View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self loadData];
    self.page = 1;
    NSArray *arr = SQgetCacheByKey(@"historySearch");
    [self.historyArr addObjectsFromArray:arr];
    if (self.historyArr.count > 0 ) {
        _haveHistoryNote = YES;
    }
    [self createSearchBar];
    [self createNavItem];
    [_search becomeFirstResponder];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    SQCacheKey_Object(@"historySearch", self.historyArr);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --网络请求

- (void)loadData {
    [NetWorkManager getDataWithURL:YSQ_BBS_HOT_SEARCH success:^(id responseObject) {
        self.hotSearchKeys = responseObject[@"data"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadSearchData:(NSString *)key {
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:YSQ_SEARCH,key,self.page] success:^(id responseObject) {
        if (self.page == 1) {
            [self.cacheHeightArr removeAllObjects];
            [self.searchModelArr removeAllObjects];
        }
        NSDictionary *dict = responseObject[@"data"];
        NSArray *arr = dict[@"entry"];
        for (NSDictionary *dict in arr) {
            YSQSearchResultModel *model = [YSQSearchResultModel modelWithDictionary:dict];
            [self.searchModelArr addObject:model];
        }
        self.page++;
        [self cacheCellHeight];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)cacheCellHeight {
    NSUInteger model_count = 0;
    if (self.searchModelArr.count <= 20) {
        model_count = 0;
    } else {
        model_count = self.cacheHeightArr.count;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSUInteger index = model_count; index < self.searchModelArr.count; index++) {
            YSQSearchResultModel *model = self.searchModelArr[index];
            CGSize size = [model.title sizeForFont:[UIFont boldSystemFontOfSize:15] size:CGSizeMake(WIDTH - 65 - 10, HEIGHT) mode:NSLineBreakByWordWrapping];
            CGFloat height = size.height + 10 + 10 + 20 + 10 + 15 + 15;
            [self.cacheHeightArr addObject:@(height)];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showFooter:YES];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        });
    });
}

#pragma mark --UI

- (void)setUpTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithWhite:0.968 alpha:1.000];
    self.tableView.tableFooterView = [[UIView alloc]init];
 }

- (void)showFooter:(BOOL)isShow {
    if (!isShow) {
        self.tableView.mj_footer = nil;
    }
    if (self.tableView.mj_footer == nil && isShow) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadSearchData:self.searchKey];
        }];
        self.tableView.mj_footer = footer;
        footer.automaticallyRefresh = YES;
        footer.automaticallyHidden = YES;
    }
}

- (void)createNavItem {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    [btn addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createSearchBar {
    _search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, WIDTH - 120, 30)];
    //修改光标颜色
    _search.tintColor = [UIColor greenColor];
    _search.delegate = self;
    _search.placeholder = @"                                          ";
    self.navigationItem.titleView = _search;

    //修改输入框边框颜色
    _search.barTintColor = [UIColor colorWithRed:0.002 green:0.861 blue:0.004 alpha:1.000];
    UIView *searchTextField = [[[self.search.subviews firstObject] subviews] lastObject];
    searchTextField.layer.borderColor = [UIColor greenColor].CGColor;
    searchTextField.layer.borderWidth = 1;
    searchTextField.layer.cornerRadius = 10;
    searchTextField.layer.masksToBounds = YES;
}

- (void)cancelSearch {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        [self showFooter:NO];
        self.isSearch = NO;
        [self.tableView reloadData];
    }
}

//开启搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_search resignFirstResponder];
    self.page = 1;
    self.isSearch = YES;
    self.searchKey = [_search.text stringByURLEncode];
    [self loadSearchData:self.searchKey];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isSearch) {
        return 1;
    }
    if (_haveHistoryNote) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isSearch) {
        return self.searchModelArr.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_isSearch) {
        return 0.5;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_isSearch) {
        return nil;
    }
    NSString *title = @"热门搜索";
    BOOL haveBtn = NO;
    if (section == 0 && _haveHistoryNote) {
        title = @"历史记录";
        haveBtn = _haveHistoryNote;
    }
    YSQSearchHeadView *view = [[YSQSearchHeadView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40) Title:title haveBtn:haveBtn];
    view.callBack = ^ {
        [self.historyArr removeAllObjects];
        _haveHistoryNote = NO;
        [self.tableView reloadData];
    };
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isSearch) {
        YSQSearchCell *cell = [YSQSearchCell cellWithTableView:tableView];
        YSQSearchResultModel *model = self.searchModelArr[indexPath.row];
        [cell setDataWithModel:model];
        self.tableView.rowHeight = [self.cacheHeightArr[indexPath.row] floatValue];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor colorWithWhite:0.968 alpha:1.000];
    }
    [cell.contentView removeAllSubviews];
    NSArray *arr ;
    if (_haveHistoryNote && indexPath.section == 0) {
        arr = [self.historyArr copy];
    } else {
        arr = self.hotSearchKeys;
    }
    YSQTagView *tag = [YSQTagView initWithTagArr:arr];
    tag.cornerRadius = 12;
    tag.delegate = self;
    tag.borderColor = [UIColor redColor];
    tag.widthToLeft = 30;
    tag.widthToRight = 30;
    [cell.contentView addSubview:tag];
    self.tableView.rowHeight = [tag countHeight];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_isSearch) {
        YSQWebViewController *web = [[YSQWebViewController alloc]init];
        YSQSearchResultModel *model = self.searchModelArr[indexPath.row];
        web.url = model.view_url;
        [self.navigationController pushViewController:web animated:YES];
    }
}

#pragma mark --YSQTagViewDelegate

- (void)clickedBtn:(NSString *)currentTitle {
    [_search resignFirstResponder];
    _search.text = currentTitle;
    _haveHistoryNote = YES;
    _isSearch = YES;
    _page = 1;
    self.searchKey = [currentTitle stringByURLEncode];
    [self loadSearchData:self.searchKey];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self addHistorySearch:currentTitle];
    });
}

- (void)addHistorySearch:(NSString *)searchKey {
    for (NSString *key in self.historyArr) {
        if ([key isEqualToString:searchKey]) {
            return;
        }
    }
    [self.historyArr addObject:searchKey];
}

@end
