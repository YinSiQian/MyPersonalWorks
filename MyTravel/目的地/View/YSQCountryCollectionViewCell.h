//
//  YSQCountryCollectionViewCell.h
//  MyTravel
//
//  Created by ysq on 16/2/7.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQCountry;
@interface YSQCountryCollectionViewCell : UICollectionViewCell

- (void)setDataWithModel:(YSQCountry *)model;
@end
