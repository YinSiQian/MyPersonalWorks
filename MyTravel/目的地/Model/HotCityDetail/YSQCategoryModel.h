//
//  YSQCategoryModel.h
//  MyTravel
//
//  Created by ysq on 16/6/28.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQCategoryModel : NSObject

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) NSArray *children;

@end

@interface YSQChildrenModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;



@end