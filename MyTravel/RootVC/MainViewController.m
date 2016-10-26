//
//  MainViewController.m
//  MyTravel
//
//  Created by ysq on 16/1/3.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "MainViewController.h"
#import "BBSViewController.h"
#import "RecomendViewController.h"
#import "DestinationViewController.h"
#import "RDVTabBarItem.h"
#import "YSQNavgationController.h"

@interface MainViewController ()<RDVTabBarControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLine];
    self.tabBar.backgroundView.backgroundColor = [UIColor whiteColor];
    [self setUpViewControllers];
    self.delegate = self;
}

- (void)addLine {
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    line.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.tabBar addSubview:line];
}

- (void)setUpViewControllers {
    
//    RecomendViewController * recommend = [[RecomendViewController alloc]init];
//    recommend.title = @"推荐";
//    YSQNavgationController * recomNav = [[YSQNavgationController alloc]initWithRootViewController:recommend];
//    
//    DestinationViewController * destiantion = [[DestinationViewController alloc]init];
//    destiantion.title = @"目的地";
//    YSQNavgationController * desNav = [[YSQNavgationController alloc]initWithRootViewController:destiantion];
//    
//    BBSViewController * bbs = [[BBSViewController alloc]init];
//    bbs.title = @"社区";
//    YSQNavgationController * bbsNav = [[YSQNavgationController alloc]initWithRootViewController:bbs];
    
//    MineViewController * mine = [[MineViewController alloc]init];
//    mine.title = @"我的";
//    YSQNavgationController * mineNav = [[YSQNavgationController alloc]initWithRootViewController:mine];
//    
//    NSArray *items = @[recomNav,desNav,bbsNav,mineNav];
//    self.viewControllers = items;
//    [self customizeTabBarForController:self];
    
    
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    NSArray *tabBarItemTitles = @[@"推荐", @"目的地", @"社区", @"我的"];
    NSArray *tabBarItemImages = @[@"recommend", @"destination", @"bbs",  @"my"];
    
    NSDictionary *selectedTitleAttributes = nil;
    NSDictionary *unselectedTitleAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        unselectedTitleAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName: [UIColor colorWithRed:0.312 green:0.317 blue:0.300 alpha:1.000]};
        
        selectedTitleAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName: [UIColor colorWithRed:0.192 green:0.784 blue:0.525 alpha:1.000]};
        
    }
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        //        设置title
        item.title = tabBarItemTitles[index];
        //         获取为选中图片的名字
        NSString *normalImageName = [NSString stringWithFormat:@"%@_normal",tabBarItemImages[index]];
        //        获取选中状态图表的名字
        NSString *selectedImageName = [NSString stringWithFormat:@"%@_selected",tabBarItemImages[index]];
        //        选中状态的image
        UIImage *selectImage = [UIImage imageNamed:selectedImageName];
        //        未选中状态的image
        UIImage *unselectImage = [UIImage imageNamed:normalImageName];
        //        设置item选中和未选中的图标
        [item setFinishedSelectedImage:selectImage withFinishedUnselectedImage:unselectImage];
        //        设置选中状态title的字体大小和颜色
        item.selectedTitleAttributes = selectedTitleAttributes;
        //        设置未选中状态title的字体大小和颜色
        item.unselectedTitleAttributes = unselectedTitleAttributes;
        
        index++;
    }

}

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    //TODO 登录时的处理
    return YES;
}


@end
