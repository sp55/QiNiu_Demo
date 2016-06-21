//
//  AppDelegate.m
//  QiNiu_Demo
//
//  Created by admin on 16/6/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "AppDelegate.h"
#import "QNNavigationViewController.h"//NavigationController
#import "QNTabBarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate



#pragma mark ------ keyboard监听
- (void)initIQKeyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];//开启
    manager.enable = YES;//点击空白区域 自动退出键盘
    manager.shouldResignOnTouchOutside = YES;//键盘的工具条上: 前后箭头+完成箭头
    manager.shouldToolbarUsesTextFieldTintColor = YES;//控制键盘上的工具条文字颜色是否用户自定义
    manager.enableAutoToolbar = NO;//控制是否显示键盘上的工具条
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //修改状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.window =[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [GLobalRealReachability startNotifier];//网络监控
    [self initIQKeyboardManager];//键盘监听

    [self showTabBar];
    
    [self.window makeKeyAndVisible];
    self.window.backgroundColor =[UIColor whiteColor];
    
    return YES;
}

#pragma mark - showTabBar
-(void)showTabBar
{
    QNTabBarViewController *tabbar=[[QNTabBarViewController alloc]init];
    self.window.rootViewController = tabbar;
}


+(AppDelegate *)sharedappDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
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
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
