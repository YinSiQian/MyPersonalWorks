//
//  AppDelegate.m
//  MyTravel
//
//  Created by ysq on 16/1/2.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "YSQTabBarController.h"
#import "RealReachability.h"
#import "JPUSHService.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
#import "FMDB.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()
@property (nonatomic, assign) NSInteger count;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [GLobalRealReachability startNotifier];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //    添加额外的代码
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar appearance] setTintColor:YSQGreenColor(1.0)];
    [[UINavigationBar appearance] setBarTintColor:YSQGreenColor(1.0)];
    YSQTabBarController *ysq = [[YSQTabBarController alloc]init];
    [self.window setRootViewController:ysq];
    [self.window makeKeyAndVisible];
    
    //创建数据库
    [self createDB];
    
    //高德地图
    [AMapServices sharedServices].apiKey = @"82fdb6b5428cbfb639f60dbb6e76366a";

    //社会化分享
    [UMSocialData setAppKey:@"5739311ae0f55a387100020c"];
    [UMSocialConfig setFinishToastIsHidden:NO position:UMSocialiToastPositionCenter];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3023336422" secret:@"Secret：c838094f7b7833934a36e531fc107801" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialQQHandler setQQWithAppId:@"1105328939" appKey:@"SjKnXodC8tXTKBOr" url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:@"wx38f765de0ce249e5" appSecret:@"6eaf1ce5ea22953fc5cfe0a3d23a83b3" url:@"http://www.umeng.com/social"];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:PUSHKEY channel:@"AppStore" apsForProduction:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    
    return YES;
}

- (void)createDB {
    NSString *dbPath = [YSQHelp getDBPath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];    
}

- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    if (status == 0) {
        [self alterViewWhenNetworkIsNone];
    }
}

- (void)alterViewWhenNetworkIsNone {
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前网络连接不稳定,请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 0) {
//        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//            [[UIApplication sharedApplication] openURL:url];
//        }
//    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation {
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"1");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
