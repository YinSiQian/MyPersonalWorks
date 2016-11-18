//
//  MTNavgationController.m
//  MyTravel
//
//  Created by ysq on 16/1/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQNavgationController.h"
#import "RecomendViewController.h"
#import "DestinationViewController.h"
#import "YSQBBSContentViewController.h"
#import "YSQMineController.h"
#import "YSQShopController.h"

@interface YSQNavgationController ()

@end

@implementation YSQNavgationController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationBar.translucent = YES;
    //设置返回按钮不带文字.
//     [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = nil;
    //[self addline];
}

- (void)addline {
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, WIDTH, 1)];
    line.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.974];
    [self.navigationBar addSubview:line];
}

/**
 *  重写这个方法,能拦截所有的push操作
 *
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        [viewController.navigationController.navigationBar setShadowImage:nil];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        viewController.hidesBottomBarWhenPushed = YES;
        NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
        self.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = item;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popAction];
    [super popViewControllerAnimated:YES];
}

- (void)subClassHandlePopAction {
    [self popAction];
}

- (void)popAction {
    UIViewController *popView = self.viewControllers[self.viewControllers.count - 1];
    [popView.navigationController.navigationBar setShadowImage:nil];
    if ([self.topViewController isKindOfClass:[RecomendViewController class]] || [self.topViewController isKindOfClass:[YSQBBSContentViewController class]] || [self.topViewController isKindOfClass:[YSQMineController class]] || [self.topViewController isKindOfClass:[DestinationViewController class]] || [self.topViewController isKindOfClass:[YSQShopController class]]) {
        NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        self.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }

}

@end
