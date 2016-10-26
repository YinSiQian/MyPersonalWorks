//
//  YSQFooterView.h
//  MyTravel
//
//  Created by ysq on 16/3/25.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SeeMoreTopic,
    SeeMoreDiscount,
} SeeMoreType;


typedef void(^seeTopic)(SeeMoreType type);

@interface YSQFooterView : UIView

@property (nonatomic, copy) seeTopic seeMoreTopic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) SeeMoreType type;

- (void)setSeeMoreTopic:(seeTopic)seeMoreTopic;

@end
