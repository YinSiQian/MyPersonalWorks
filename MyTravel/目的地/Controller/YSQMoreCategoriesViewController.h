//
//  YSQMoreCategoriesViewController.h
//  MyTravel
//
//  Created by ysq on 16/6/28.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSQMoreCategoriesViewController : UIViewController
@property (nonatomic, copy) NSNumber *city_id;
@property (nonatomic, copy) void (^callBack)(NSString *category_id, NSString *tag_id);
@end
