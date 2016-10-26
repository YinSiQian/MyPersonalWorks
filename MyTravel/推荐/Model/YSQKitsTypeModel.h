//
//  YSQKitsTypeModel.h
//  MyTravel
//
//  Created by ysq on 16/4/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSQKitsTypeModel : NSObject

@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *mobile_count;
@property (nonatomic, strong) NSNumber *pdf_count;
@property (nonatomic, copy) NSString *pinyin;


@end
