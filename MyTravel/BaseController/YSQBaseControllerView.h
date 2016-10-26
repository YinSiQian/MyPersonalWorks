//
//  YSQBaseControllerView.h
//  MyTravel
//
//  Created by ysq on 16/1/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSQBaseControllerView : UIViewController

///**
// *  上拉加载,下拉刷新,子类有该功能,则实现该Block
// */
//@property (nonatomic, strong) void (^headerRrefresh)(void);
//@property (nonatomic, strong) void (^footerRrefresh)(void);
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

- (void)createTableView;

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 *  默认返回一个section
 
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

/**
 *  默认返回nil
 
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

/**
 *  默认返回nil
 
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

/**
 *  子类必须实现
 
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end
