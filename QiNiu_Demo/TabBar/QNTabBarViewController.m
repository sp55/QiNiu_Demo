//
//  QNTabBarViewController.m
//  QiNiu_Demo
//
//  Created by admin on 16/6/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "QNTabBarViewController.h"
#import "QNMeViewController.h"
#import "QNHomeViewController.h"
#import "QNNavigationViewController.h"
@interface QNTabBarViewController ()

@end

@implementation QNTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:@"QNHomeViewController" title:@"首页" image:@"eh_tabbar_home_normal" selectedImage:@"eh_tabbar_home_selected"];
    [self addChildViewController:@"QNMeViewController" title:@"我的" image:@"eh_tabbar_mine_normal" selectedImage:@"eh_tabbar_mine_selected"];
    
    
}

- (void)addChildViewController:(NSString *)childController title:(NSString *)title image:(NSString *)normalImg selectedImage:(NSString *)selectedImg {
    Class class = NSClassFromString(childController);
    BaseViewController *controller = [[class alloc] init];
    controller.title = title;
    
    QNNavigationViewController *navi = [[QNNavigationViewController alloc] initWithRootViewController:controller];
    [navi.tabBarItem setImage:[[UIImage imageNamed:normalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navi.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [navi.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0f]} forState:UIControlStateNormal];
    [navi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : HexRGB(0x00aaee)} forState:UIControlStateSelected];
    [self addChildViewController:navi];
}


@end
