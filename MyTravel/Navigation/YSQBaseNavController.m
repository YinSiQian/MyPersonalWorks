//
//  YSQBaseNavController.m
//  MyTravel
//
//  Created by 尹思迁 on 2016/11/17.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQBaseNavController.h"
#import "AppDelegate.h"
#import "ScreenShotView.h"

#define ENABLE_POP 100

@interface YSQBaseNavController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, strong) NSMutableArray *screenShotArr;

@end

@implementation YSQBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.enabled = NO;
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    self.panGesture.delegate = self;
    [self.view addGestureRecognizer:self.panGesture];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.view == self.view) {
        UIViewController *topView = self.topViewController;
        if (topView.forbidPop) {
            return NO;
        }
        CGPoint translate = [gestureRecognizer translationInView:self.view];
        CGPoint dot = [gestureRecognizer locationInView:self.view];
        BOOL enable = translate.x != 0 && fabs(translate.y) >= 0 && dot.y >= 64;
        if (enable) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIPanGestureRecognizer")] ) {
        //设置该条件是避免跟tableview的删除，筛选界面展开的左滑事件有冲突
        return NO;
    }
    return YES;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //NSInteger kScreen = [UIScreen mainScreen].bounds.size.width;
    UIViewController *rootVC = appdelegate.window.rootViewController;
    UIViewController *presentedVC = rootVC.presentedViewController;
    if (self.viewControllers.count == 1)
    {
        return;
    }
    if (panGesture.state == UIGestureRecognizerStateBegan)
    {
        appdelegate.shotView.hidden = NO;
        appdelegate.shotView.imgView.image = self.screenShotArr[self.screenShotArr.count - 1];
    }
    else if (panGesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint point_inView = [panGesture translationInView:self.view];
        
        if (point_inView.x >= 10)
        {
            rootVC.view.transform = CGAffineTransformMakeTranslation(point_inView.x - 10, 0);
            appdelegate.shotView.transform = CGAffineTransformMakeTranslation (point_inView.x, 0);
            presentedVC.view.transform = CGAffineTransformMakeTranslation(point_inView.x - 10, 0);
        }
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint point_inView = [panGesture translationInView:self.view];
        if (point_inView.x >= ENABLE_POP)
        {
            
            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionOverrideInheritedCurve  animations:^{
                rootVC.view.transform = CGAffineTransformMakeTranslation(WIDTH , 0);
                appdelegate.shotView.transform = CGAffineTransformMakeTranslation(WIDTH , 0);
                presentedVC.view.transform = CGAffineTransformMakeTranslation(WIDTH , 0);
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                rootVC.view.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformIdentity;
                appdelegate.shotView.hidden = YES;
                appdelegate.shotView.transform = CGAffineTransformMakeTranslation(-WIDTH , 0);
            }];
        }
        else
        {
            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
                rootVC.view.transform = CGAffineTransformIdentity;
                appdelegate.shotView.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                appdelegate.shotView.hidden = YES;
            }];
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(appdelegate.window.frame.size.width, appdelegate.window.frame.size.height), YES, 0);
    [appdelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.screenShotArr addObject:viewImage];
    appdelegate.shotView.imgView.image = viewImage;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.screenShotArr removeLastObject];
    UIImage *image = [self.screenShotArr lastObject];
    if (image)
        appdelegate.shotView.imgView.image = image;
    [self subClassHandlePopAction];
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (self.screenShotArr.count > 2)
    {
        [self.screenShotArr removeObjectsInRange:NSMakeRange(1, self.screenShotArr.count - 1)];
    }
    UIImage *image = [self.screenShotArr lastObject];
    if (image)
        appdelegate.shotView.imgView.image = image;
    [self subClassHandlePopAction];
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *arr = [super popToViewController:viewController animated:animated];
    
    if (self.screenShotArr.count > arr.count)
    {
        for (int i = 0; i < arr.count; i++) {
            [self.screenShotArr removeLastObject];
        }
    }
    [self subClassHandlePopAction];
    return arr;
}

- (void)subClassHandlePopAction {
    //交由子类去处理一些Pop之后具体的业务事件.
}


- (NSMutableArray *)screenShotArr {
    if (!_screenShotArr) {
        _screenShotArr = [NSMutableArray array];
    }
    return _screenShotArr;
}


@end
