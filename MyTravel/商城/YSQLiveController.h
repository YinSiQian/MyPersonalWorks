//
//  YSQLiveController.h
//  MyTravel
//
//  Created by ysq on 2016/10/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSQLiveItem;
@interface YSQLiveController : UICollectionViewController
@property (nonatomic, copy) NSArray<YSQLiveItem *> *liveModelArr;
@property (nonatomic, assign) NSInteger selectedIndex;
@end
