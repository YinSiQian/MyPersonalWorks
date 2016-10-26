//
//  YSQMineController.m
//  MyTravel
//
//  Created by ysq on 16/3/8.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQMineController.h"
#import "YSQMineHeaderView.h"
#import "YSQUserDAO.h"

@interface YSQMineController ()

@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, strong) YSQMineHeaderView *headerView;

@end

@implementation YSQMineController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQGreenColor(self.alpha)] forBarMetrics:UIBarMetricsDefault];
    });
    [self loadUserData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(1)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [self createHeaderView];
    //http://static.qyer.com/images/user2/index/headImage_lite.png 背景图片
    //http://static.qyer.com/images/user2/avatar/big1.png 头像
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUserData {
    YSQUserDAO *user = [YSQUserDAO shared];
    self.headerView.name.text = user.username;
}

#pragma mark --HeaderView

- (void)createHeaderView {
    self.headerView = [[YSQMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 240)];
    self.tableView.tableHeaderView = self.headerView;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset=scrollView.contentOffset.y;
    self.alpha =1-((64-offset)/64);
    if (offset > 64) {
        self.alpha = 0.995792;
    }
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQGreenColor(self.alpha)] forBarMetrics:UIBarMetricsDefault];
    
    YSQMineHeaderView *headerView = (id) self.tableView.tableHeaderView;
    [headerView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  section == 0 ? 11 : 0.1;
}

//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
