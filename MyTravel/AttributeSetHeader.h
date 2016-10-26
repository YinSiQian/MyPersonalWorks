//
//  AttributeSetHeader.h
//  MyTravel
//
//  Created by ysq on 16/3/2.
//  Copyright © 2016年 ysq. All rights reserved.
//

#ifndef AttributeSetHeader_h
#define AttributeSetHeader_h

#define SQgetCacheByKey(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define SQCacheKey_Object(key,object)    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];[[NSUserDefaults standardUserDefaults] synchronize]
#define SQDeleteCacheByKey(key)     [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
#define SQNotiCenter [NSNotificationCenter defaultCenter] 


#define YSQBlack                [UIColor blackColor]
#define YSQRed                   [UIColor redColor]
#define YSQGray                 [UIColor colorWithWhite:0.800 alpha:1.000]
#define YSQSteel                 [UIColor colorWithWhite:0.200 alpha:1.000]
#define YSQOrange            [UIColor orangeColor]
#define YSQSmallBlack     [UIColor colorWithWhite:0.498 alpha:1.000]
#define YSQLikeRed(alp)           [UIColor colorWithRed:1.000 green:0.042 blue:0.474 alpha:alp]
#define YSQGreenColor(alp)   [UIColor colorWithRed:0.063 green:0.718 blue:0.392 alpha:alp]
#define YSQWhiteColor(alp)    [UIColor colorWithWhite:0.987 alpha:alp]


#define YSQLittleFont [UIFont systemFontOfSize:10]
#define YSQSamllFont [UIFont systemFontOfSize:12]
#define YSQNormalFont [UIFont systemFontOfSize:14]
#define YSQBoldFont     [UIFont boldSystemFontOfSize:16]
#endif /* AttributeSetHeader_h */
