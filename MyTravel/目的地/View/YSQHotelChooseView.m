//
//  YSQHotelChooseView.m
//  MyTravel
//
//  Created by ysq on 16/2/12.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQHotelChooseView.h"

@interface  YSQHotelChooseView ()
@property (weak, nonatomic) IBOutlet UIButton *searchHotel;

@property (weak, nonatomic) IBOutlet UIButton *recommendHotel;
@property (weak, nonatomic) IBOutlet UIButton *discountHotel;

@end

@implementation YSQHotelChooseView

- (void)layoutSubviews {
    self.searchHotel.layer.cornerRadius = 5;
    self.searchHotel.layer.masksToBounds = YES;
    self.recommendHotel.layer.cornerRadius = 5;
    self.recommendHotel.layer.masksToBounds = YES;
    self.discountHotel.layer.cornerRadius = 5;
    self.discountHotel.layer.masksToBounds = YES;
}

+ (YSQHotelChooseView *)hotelChooseView {
    YSQHotelChooseView *chooseView = [[[NSBundle mainBundle] loadNibNamed:@"YSQHotelChooseView" owner:nil options:nil] lastObject];
    return chooseView;
}

@end
