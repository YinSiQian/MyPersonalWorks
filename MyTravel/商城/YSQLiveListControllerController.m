//
//  YSQLiveListControllerController.m
//  MyTravel
//
//  Created by ysq on 2016/10/5.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQLiveListControllerController.h"
#import "YSQLiveItem.h"
#import "YZLiveCell.h"
#import "YSQLiveController.h"


@interface YSQLiveListControllerController ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

static NSString *const reuse = @"reuseCell";

@implementation YSQLiveListControllerController

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray  array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直播列表";
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"YZLiveCell" bundle:nil] forCellReuseIdentifier:reuse];
    [self loadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    [NetWorkManager getDataWithURL:urlStr success:^(id responseObject) {
        NSArray *arr = responseObject[@"lives"];
        for (NSDictionary *dict in arr) {
            YSQLiveItem *item = [YSQLiveItem modelWithDictionary:dict];
            [self.dataArr addObject:item];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    cell.live = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSQLiveController *liveVc = [[YSQLiveController alloc] init];
    liveVc.liveModelArr = [self.dataArr copy];
    liveVc.selectedIndex = indexPath.row;
    [self presentViewController:liveVc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 430;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
