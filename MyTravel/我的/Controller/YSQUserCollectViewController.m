//
//  YSQUserCollectViewController.m
//  MyTravel
//
//  Created by ysq on 16/5/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQUserCollectViewController.h"
#import "YSQPlayModel.h"
#import "YSQPlayCell.h"

@interface YSQUserCollectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation YSQUserCollectViewController

#pragma mark --懒加载

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark --View life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self createTableView];
    [self loadData];
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --数据请求
- (void)loadData {
    [NetWorkManager getDataWithURL:@"http://localhost:63342/htdocs/YSQTravelAPI/getCollect.php" success:^(id responseObject) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSArray *arr = responseObject[@"data"];
        for (NSDictionary *dict in arr) {
            YSQPlayModel *model = [YSQPlayModel modelWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
        NSLog(@"%@",error);
    }];
}

- (void)deleteCollect:(NSNumber *)ID {
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

#pragma mark --UI

- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

#pragma mark --UITableViewDelegate&UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSQPlayCell *cell = [YSQPlayCell cellWithTableView:tableView];
    YSQPlayModel *model = self.dataArray[indexPath.row];
    cell.isShow = YES;
    [cell setDataWithModel:model];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        YSQPlayModel *model = self.dataArray[indexPath.row];
        [self deleteCollect:model.ID];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowAtIndexPath:indexPath  withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
