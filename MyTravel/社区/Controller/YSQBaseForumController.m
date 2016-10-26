//
//  YSQBaseForumController.m
//  MyTravel
//
//  Created by ysq on 16/4/30.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQBaseForumController.h"
#import "YSQNewInfoCell.h"
#import "YSQAskCell.h"
#import "YSQTravelGuideCell.h"
#import "YSQForumDetailModel.h"
#import "YSQAskModel.h"
#import "YSQCompanyModel.h"
#import "HMSegmentedControl.h"
#import "YSQWebViewController.h"

@interface YSQBaseForumController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) HMSegmentedControl *segment;
@property (nonatomic, assign) BOOL isReload;


@end

@implementation YSQBaseForumController

#pragma mark --懒加载

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark ---View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    [self createHeaderView];
    [self createTableView];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canScroll) name:@"enableScroll" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unableScroll) name:@"unableScroll" object:nil];

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)unableScroll {
    self.tableView.scrollEnabled = NO;
}

- (void)canScroll {
    self.tableView.scrollEnabled = YES;
}

- (void)loadData {
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.tableView];
    [NetWorkManager getDataWithURL:[NSString stringWithFormat:self.urlString,self.forum_id,self.page] success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.tableView];
        id data = responseObject[@"data"];
        if ([data isKindOfClass:[NSDictionary class]]) {
            YSQForumDetailModel *model = [YSQForumDetailModel modelWithDictionary:data];
            if (self.isReload) {
                [self.dataArray removeAllObjects];
                self.isReload = NO;
            }
            self.detailModel = model;
            [self.dataArray addObject:model];
        } else if ([data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in data) {
                if (dict[@"answer_num"]) {
                    YSQAskModel *model = [YSQAskModel modelWithDictionary:dict];
                    [self.dataArray addObject:model];
                } else {
                    YSQCompanyModel *model = [YSQCompanyModel modelWithDictionary:dict];
                    [self.dataArray addObject:model];
                }
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 100) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
}

- (void)createHeaderView {
    self.segment = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"全部",@"精华",@"游记",@"攻略"]];
    self.segment.frame = CGRectMake(WIDTH / 5, 64, WIDTH *4 / 5.0, 40);
    self.segment.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    self.segment.selectedSegmentIndex = 0;
    self.segment.selectionIndicatorHeight = 0;
    self.segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    self.segment.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : [UIColor colorWithWhite:0.702 alpha:1.000]};
    self.segment.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.098 alpha:1.000]};
    self.segment.borderType = HMSegmentedControlBorderTypeBottom;
    self.segment.borderColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    self.segment.borderWidth = 0.5;
    __weak typeof(self) weakSelf = self;
    [self.segment setIndexChangeBlock:^(NSInteger index) {
        weakSelf.isReload = YES;
        switch (index) {
            case 0:{
                weakSelf.page = 1;
                weakSelf.urlString = YSQ_BBS_DETAIL_METHODAll_URL;
            }
                break;
            case 1:{
                weakSelf.page = 1;
                weakSelf.urlString = YSQ_BBS_DETAIL_ASSIGN_URL;
            }
                break;
            case 2: {
                weakSelf.page = 1;
                weakSelf.urlString = YSQ_BBS_DETAIL_NOTE_URL;
            }
                break;
            case 3: {
                weakSelf.page = 1;
                weakSelf.urlString = YSQ_BBS_DETAIL_METHOD_URL;
            }
                break;
            default:
                break;
        }
        [weakSelf loadData];
        [weakSelf.tableView scrollToTop];
    }];

}


#pragma mark --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataArray.firstObject isKindOfClass:[YSQForumDetailModel class]]) {
        return [[self.dataArray.firstObject entry] count];
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isStrategy) {
        return 40;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.isStrategy ) {
        return self.segment;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.cellType) {
        case YSQForumAskCell: {
            YSQAskCell *cell = [YSQAskCell cellWithTableView:tableView];
            YSQAskModel *model = self.dataArray[indexPath.row];
            [cell setDataWithModel:model];
            return cell;
        }
            break;
        case YSQForumNewInfoCell: {
            YSQNewInfoCell *cell = [YSQNewInfoCell cellWithTableView:tableView];
            YSQForumDetailModel *model = self.dataArray.firstObject;
            YSQEntryModel *entry = model.entry[indexPath.row];
            [cell setDataWithModel:entry];
            return cell;
        }
            break;
        case YSQForumTravelGuideCell: {
            YSQTravelGuideCell *cell = [YSQTravelGuideCell cellWithTableView:tableView];
            YSQForumDetailModel *model = self.dataArray.firstObject;
            YSQEntryModel *entry = model.entry[indexPath.row];
            [cell setDataWithModel:entry];
            return cell;
        }
            break;
        case YSQForumCompanyCell: {
            YSQAskCell *cell = [YSQAskCell cellWithTableView:tableView];
            YSQCompanyModel *model = self.dataArray[indexPath.row];
            [cell setDataWithCMModel:model];
            return cell;
        }
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    YSQWebViewController *web = [[YSQWebViewController alloc]init];
    switch (self.cellType) {
        case YSQForumAskCell: {
            YSQAskModel *model = self.dataArray[indexPath.row];
            web.url = model.appview_url;
        }
            break;
        case YSQForumNewInfoCell: {
            YSQForumDetailModel *model = self.dataArray.firstObject;
            YSQEntryModel *entry = model.entry[indexPath.row];
            web.url = entry.view_url;
        }
            break;
        case YSQForumTravelGuideCell: {
            YSQForumDetailModel *model = self.dataArray.firstObject;
            YSQEntryModel *entry = model.entry[indexPath.row];
            web.url = entry.view_url;
        }
            break;
        case YSQForumCompanyCell: {
            YSQCompanyModel *model = self.dataArray[indexPath.row];
            web.url = model.appview_url;
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:web animated:YES];
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    self.offset =  scrollView.contentOffset.y;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"offset" object:nil userInfo:@{@"offset":@(self.offset)}];
//
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.offset =  scrollView.contentOffset.y;
    if (self.offset < 0) {
        self.tableView.scrollEnabled = NO;
    } else if (self.offset <= 5) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"offset" object:nil userInfo:@{@"offset":@(self.offset)}];
    }
}


@end
