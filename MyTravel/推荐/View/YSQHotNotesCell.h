//
//  MTHotNotesCell.h
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSQHotNotesModel;
@interface YSQHotNotesCell : UITableViewCell
- (void)setDataWithModel:(YSQHotNotesModel *)model;
@end
