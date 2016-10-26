//
//  YSQAddressViewController.m
//  MyTravel
//
//  Created by ysq on 16/5/24.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQAddressViewController.h"
#import "YSQAddressModel.h"
#import "YSQAddressCell.h"
#import "YSQHotCityCell.h"


@interface YSQAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionIndexArr;
@property (nonatomic, strong) NSMutableArray *hotArray;
@end

@implementation YSQAddressViewController


#pragma mark --懒加载

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)hotArray {
    if (!_hotArray) {
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}

- (NSMutableArray *)sectionIndexArr {
    if (!_sectionIndexArr) {
        _sectionIndexArr = [NSMutableArray array];
    }
    return _sectionIndexArr;
}

#pragma mark --View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
    [self createTableView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --数据请求

- (void)loadData {
    [NetWorkManager getDataWithURL:YSQ_LOCATION_URL success:^(id responseObject) {
        NSArray *arr = responseObject[@"data"];
        NSMutableArray *originArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            YSQAddressModel *model = [YSQAddressModel modelWithDictionary:dict];
            [originArr addObject:model];
        }
        [self hanldeData:originArr];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)hanldeData:(NSMutableArray *)dataArr {
    //拿出热门城市
    for (YSQAddressModel *model in dataArr) {
        if (model.is_hot.boolValue) {
            [self.hotArray addObject:model];
        }
    }
    [dataArr removeObjectsInRange:NSMakeRange(0, 9)];
    //冒泡排序
    for (int index = 0; index < dataArr.count; index++) {
        for (int j = index; j < dataArr.count; j++) {
            YSQAddressModel *m1 = dataArr[index];
            YSQAddressModel *m2 = dataArr[j];
            if ([m1.pinyin localizedCompare:m2.pinyin] == 1) {
                [dataArr exchangeObjectAtIndex:index withObjectAtIndex:j];
            }
        }
    }
    //获取sectionIndexArr
    for (YSQAddressModel *model in dataArr) {
        NSString *indexStr = [self getAnyLetter:model];
        int count = 0;
        for (NSString *value in self.sectionIndexArr) {
            if (![value.uppercaseString isEqualToString:indexStr.uppercaseString]) {
                count++;
            }
            if (count == self.sectionIndexArr.count) {
                [self.sectionIndexArr addObject:indexStr.uppercaseString];
            }
        }
        if (self.sectionIndexArr.count == 0) {
            [self.sectionIndexArr addObject:indexStr.uppercaseString];
        }
    }
    [self.sectionIndexArr insertObject:@"热门" atIndex:0];
    
    //排序后数据分组
    for (int index = 'a' ; index <= 'z' ; index ++) {
        NSMutableArray *data = [NSMutableArray array];
        for (YSQAddressModel *model in dataArr) {
            if ([[self getAnyLetter:model]  isEqualToString:[NSString stringWithFormat:@"%c",index]]) {
                [data addObject:model];
            }
        }
        if (data.count != 0) {
            [self.dataArray addObject:data];
        }
    }
    [self.tableView reloadData];
}

- (NSString *)getAnyLetter:(YSQAddressModel *)model {
    NSString *result = [model.pinyin substringWithRange:NSMakeRange(0, 1)];
    return result;
}

#pragma mark --UI

- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    //修改索引条颜色
    self.tableView.sectionIndexColor = [UIColor grayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
}

#pragma mark --UITableViewDataSource 

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexArr;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index - 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count !=0 ? self.dataArray.count + 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [self.dataArray[section - 1] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 250;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YSQHotCityCell *hotCell = [YSQHotCityCell cellWithTableView:tableView];
        hotCell.dataArr = [self.hotArray copy];
        return hotCell;
    } else {
        YSQAddressCell *cell = [YSQAddressCell cellWithTableView:tableView];
        NSArray *data = self.dataArray[indexPath.section - 1];
        YSQAddressModel *model = data[indexPath.row];
        [cell setDataWithModel:model];
        return cell;
    }
}

@end
