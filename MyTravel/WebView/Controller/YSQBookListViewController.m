//
//  YSQBookListViewController.m
//  MyTravel
//
//  Created by ysq on 16/6/15.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQBookListViewController.h"
#import "YSQHTMLModel.h"

@interface YSQBookListViewController ()

@end

@implementation YSQBookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"目录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    YSQHTMLModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld  %@",indexPath.row,model.title];
    cell.textLabel.font = YSQNormalFont;
    cell.textLabel.textColor = YSQGray;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.callBack) {
        self.callBack(indexPath.row);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
