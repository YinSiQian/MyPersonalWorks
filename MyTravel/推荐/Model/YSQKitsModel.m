//
//  YSQKitsModel.m
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQKitsModel.h"

@implementation YSQKitsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"guides":[YSQGuidesModel class]};
}

@end

@implementation YSQGuidesModel

@end