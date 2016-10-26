//
//  BBSViewController.m
//  MyTravel
//
//  Created by ysq on 16/1/3.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "BBSViewController.h"
#import "YSQGroupModel.h"
#import "YSQBBSCountModel.h"
#import "YSQForumModel.h"
#import "YSQForumCell.h"
#import "NSObject+YSQStore.h"
#import "YSQForumDetailController.h"
#import "YYFPSLabel.h"
#import "YSQBBSCell.h"



@interface BBSViewController ()<YSQForumCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) YSQBBSCountModel *countModel;
@property (nonatomic, copy) NSArray *listArray;
@property (nonatomic, strong) NSMutableArray *recordArr;
@property (nonatomic, strong) YYFPSLabel *fpsLabel;
@property (nonatomic, strong) NSMutableArray *leftListArr;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) UITableView *contentTableView;
@end

static NSString *const recordData = @"record";

@implementation BBSViewController

#pragma mark ---懒加载

- (NSMutableArray *)leftListArr {
    if (!_leftListArr) {
        _leftListArr = [NSMutableArray array];
    }
    return _leftListArr;
}

-(NSMutableArray *)recordArr {
    if (!_recordArr) {
        _recordArr = [NSMutableArray array];
    }
    return _recordArr;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark ---View life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
    });
    [self createFPSLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --UI 

- (void)createTableView {
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, HEIGHT  - 49 - 64) style:UITableViewStylePlain];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = [UIColor colorWithRed:0.942 green:0.945 blue:0.965 alpha:1.000];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.listTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.view addSubview:self.listTableView];
    
    self.contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(80, 0, WIDTH - 80, HEIGHT  - 64 - 49) style:UITableViewStylePlain];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.contentTableView];
}

- (void)createFPSLabel {
    _fpsLabel = [YYFPSLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.bottom = self.view.height - 30;
    _fpsLabel.left = 12;
    _fpsLabel.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:_fpsLabel];
}

#pragma mark ---网络请求

- (void)loadData {
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
    [NetWorkManager getDataWithURL:YSQ_BBS_URL success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        NSDictionary *counts = [dict objectForKey:@"counts"];
        self.countModel = [YSQBBSCountModel modelWithDictionary:counts];
        self.listArray = [dict objectForKey:@"forum_list"];
        for (NSDictionary *dic in self.listArray) {
            YSQForumModel *listModel = [YSQForumModel modelWithDictionary:dic];
            [self.leftListArr addObject:listModel.name];
            [self.dataArray addObject:listModel];
        }
        [self createTableView];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

#pragma mark ---UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:NULL];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (_fpsLabel.alpha != 0) {
            [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                _fpsLabel.alpha = 0;
            } completion:NULL];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha != 0) {
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 0;
        } completion:NULL];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark ---UITableViewDelegate & UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YSQForumModel *model = self.dataArray[self.selectedIndex];
    if (self.listTableView == tableView) {
        return self.leftListArr.count;
    }
    return model.group.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listTableView == tableView) {
        return 80;
    } else {
        return 90;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listTableView == tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"list"];
            UIView *backView = [[UIView alloc]initWithFrame:cell.frame];
            backView.backgroundColor = [UIColor whiteColor];
            cell.selectedBackgroundView = backView;
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = self.leftListArr[indexPath.row];
        cell.textLabel.font = YSQNormalFont;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    YSQBBSCell *cell = [YSQBBSCell cellWithTableView:tableView];
    YSQForumModel *model = self.dataArray[self.selectedIndex];
    YSQGroupModel *groupModel = model.group[indexPath.row];
    [cell setDataWithModel:groupModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.listTableView) {
        self.selectedIndex = indexPath.row;
        [self.contentTableView reloadData];
    } else {
        [self.contentTableView deselectRowAtIndexPath:indexPath animated:YES];
        YSQForumModel *model = self.dataArray[self.selectedIndex];
        YSQGroupModel *groupModel = model.group[indexPath.row];
        YSQForumDetailController *forum = [[YSQForumDetailController alloc]init];
        forum.name = groupModel.name;
        forum.ID = groupModel.ID;
        [self.navigationController pushViewController:forum animated:YES];
    }
}

#pragma mark ---YSQForumCellDelegate

- (void)pushToForumDetailWithModel:(YSQGroupModel *)model {
    [self handleSelectedData:model];
    YSQForumDetailController *forum = [[YSQForumDetailController alloc]init];
    forum.name = model.name;
    forum.ID = model.ID;
    [self.navigationController pushViewController:forum animated:YES];
}

#pragma mark ---处理浏览记录排序
- (void)handleSelectedData:(YSQGroupModel *)model {
    for (int index = 0; index < self.recordArr.count; index ++) {
        YSQGroupModel *recordModel = self.recordArr[index];
        if ([recordModel.ID isEqual:model.ID]) {
            [self.recordArr removeObjectAtIndex:index];
        }
    }
    [self.recordArr insertObject:model atIndex:0];
    if (self.recordArr.count > 6) {
         [self.recordArr removeObjectsInRange:NSMakeRange(6, self.recordArr.count-6)];
    }
    [self.recordArr storeValueWithKey:recordData];
}


@end
