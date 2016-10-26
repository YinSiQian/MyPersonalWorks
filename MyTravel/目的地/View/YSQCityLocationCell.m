//
//  YSQCityLocationCell.m
//  MyTravel
//
//  Created by ysq on 16/2/12.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQCityLocationCell.h"

@implementation YSQCityLocationCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuse = @"location";
    YSQCityLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSQCityLocationCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (IBAction)choose:(UIButton *)sender {
    [self isResponseDelegateWithIndex:1];
}

- (IBAction)play:(UIButton *)sender {
    [self isResponseDelegateWithIndex:2];
}
- (IBAction)food:(UIButton *)sender {
    [self isResponseDelegateWithIndex:3];
}

- (IBAction)hotel:(UIButton *)sender {
    [self isResponseDelegateWithIndex:4];
  }

- (void)isResponseDelegateWithIndex:(int)index {

    if ([self.delegate respondsToSelector:@selector(goToLocalFeaturesWithIndex:)]) {
        [self.delegate goToLocalFeaturesWithIndex:index];
    }
}

@end
