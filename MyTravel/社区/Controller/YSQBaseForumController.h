//
//  YSQBaseForumController.h
//  MyTravel
//
//  Created by ysq on 16/4/30.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YSQForumCellType) {
    YSQForumNewInfoCell,
    YSQForumTravelGuideCell,
    YSQForumAskCell,
    YSQForumCompanyCell,
};

@class YSQForumDetailModel;
@interface YSQBaseForumController : UIViewController

@property (nonatomic, strong) NSNumber *forum_id;
@property (nonatomic, assign) YSQForumCellType cellType;
@property (nonatomic, assign) BOOL isStrategy;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) YSQForumDetailModel *detailModel;
@property (nonatomic, assign) CGFloat offset;
@end
