//
//  YSQBookCell.h
//  MyTravel
//
//  Created by ysq on 16/6/14.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSQBookCell : UICollectionViewCell
- (void)loadHTMLWithHTMLPath:(NSString *)path baseURL:(NSString *)URLString;
@end
