//
//  YSQTabBarController.m
//  MyTravel
//
//  Created by ysq on 16/3/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQTabBarController.h"
#import "DestinationViewController.h"
#import "YSQBBSContentViewController.h"
#import "RecomendViewController.h"
#import "YSQNavgationController.h"
#import "YSQLoginViewController.h"
#import "YSQShopController.h"

@interface YSQTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) CATransition *transition;
@property (nonatomic, assign) BOOL isPresent;
@property (nonatomic, strong) UIImageView *selectedView;
@end

@implementation YSQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViewControllers];
    self.delegate = self;
    self.tabBar.translucent = YES;
    [self addLine];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:LoginNotification object:nil];
    
}

- (UIImageView *)selectedView {
    if (!_selectedView) {
        _selectedView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH / 5, 49)];
        _selectedView.image = [UIImage imageNamed:@"TabBar_Background_Highlight_150x100_"];
    }
    return _selectedView;
}


- (void)login {
    YSQLoginViewController *login = [[YSQLoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)addLine {
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.1)];
    line.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.tabBar addSubview:line];
}

- (void)setUpViewControllers {
    
    RecomendViewController * recommend = [[RecomendViewController alloc]init];
    recommend.title = @"推荐";
    YSQNavgationController * recomNav = [[YSQNavgationController alloc]initWithRootViewController:recommend];
    
    DestinationViewController * destiantion = [[DestinationViewController alloc]init];
    destiantion.title = @"目的地";
    YSQNavgationController * desNav = [[YSQNavgationController alloc]initWithRootViewController:destiantion];
    
    YSQShopController *shop = [[YSQShopController alloc]init];
    shop.title = @"商城";
    YSQNavgationController *shopNav = [[YSQNavgationController alloc]initWithRootViewController:shop];
    
    YSQBBSContentViewController * bbs = [[YSQBBSContentViewController alloc]init];
    bbs.title = @"社区";
    YSQNavgationController * bbsNav = [[YSQNavgationController alloc]initWithRootViewController:bbs];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"YSQMineViewController" bundle:nil];
    UIViewController *storyMine = [story instantiateViewControllerWithIdentifier:@"mine"];
    storyMine.title = @"我的";
    YSQNavgationController * mineNav = [[YSQNavgationController alloc]initWithRootViewController:storyMine];
    
    NSArray *items = @[recomNav,desNav,shopNav,bbsNav,mineNav];
    self.viewControllers = items;
    
    [self customizeTabBarForController:self];
}

- (void)customizeTabBarForController:(YSQTabBarController *)tabBarController {
    NSArray *tabBarItemTitles = @[@"推荐", @"目的地", @"旅行商城",@"社区", @"我的"];
    NSArray *tabBarItemImages = @[@"TabBar_Recommend", @"TabBar_Place",@"TabBar_Shop", @"TabBar_bbs",  @"TabBar_Mine"];
    
    NSDictionary *selectedTitleAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    NSDictionary *unselectedTitleAttributes = nil;
    
    
    
    NSInteger index = 0;
    for (UITabBarItem *item in [[tabBarController tabBar] items]) {
        //        设置title
        item.title = tabBarItemTitles[index];
        
        
        //         获取为选中图片的名字
        NSString *normalImageName = [NSString stringWithFormat:@"%@_normal",tabBarItemImages[index]];
        //        获取选中状态图表的名字
        NSString *selectedImageName = [NSString stringWithFormat:@"%@_selected",tabBarItemImages[index]];
        //        选中状态的image
        UIImage *selectImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //        未选中状态的image
        UIImage *unselectImage = [[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //          选中,未选中字体设置
        [item setTitleTextAttributes:unselectedTitleAttributes forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedTitleAttributes forState:UIControlStateSelected];
        //       设置item选中和未选中的图标
        [item setImage:unselectImage];
        
        [item setSelectedImage:selectImage];
        
        index++;
    }
    [tabBarController.tabBar addSubview:self.selectedView];
    [tabBarController.tabBar sendSubviewToBack:self.selectedView];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    if ([viewController.tabBarItem.title isEqualToString:@"我的"] && !self.isPresent ) {
//        self.isPresent = YES;
//        [[NSNotificationCenter defaultCenter] postNotificationName:LoginNotification object:nil];
//        return YES;
//    }
    
    [self.transition setDuration:0.4];
    //私有API
    //cube 3D 翻转动画
    //pageUnCurl  翻页效果上去  pageCurl 下来
    //suckEffect  吸走的效果
    //波纹 rippleEffect
    //镜头打开 cameraIrisHollowOpen cameraIrisHollowClose 关闭
    //oglFlip 翻转
    [self.transition setType:@"fade"];
    [self.view.layer addAnimation:self.transition forKey:nil];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [self movedSelectedView:self.selectedIndex];
}

- (void)movedSelectedView:(NSInteger)index {
    CGRect frame = self.selectedView.frame;
    frame.origin.x = WIDTH / 5 * index;
    self.selectedView.frame = frame;
}

- (CATransition *)transition {
    if (!_transition) {
        _transition = [CATransition animation];
    }
    return _transition;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
