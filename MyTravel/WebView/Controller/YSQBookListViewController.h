//
//  YSQBookListViewController.h
//  MyTravel
//
//  Created by ysq on 16/6/15.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSQBookListViewController : UITableViewController
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) void (^callBack)(NSInteger index);
@end
