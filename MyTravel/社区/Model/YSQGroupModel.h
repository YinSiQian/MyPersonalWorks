//
//  YSQGroupModel.h
//  MyTravel
//
//  Created by ysq on 16/3/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQGroupModel : NSObject

@property (nonatomic,strong) NSNumber *ID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *total_threads;
@property (nonatomic,copy) NSString *Description;

@end
