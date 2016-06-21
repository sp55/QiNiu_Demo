//
//  QNNavigationViewController.m
//  QiNiu_Demo
//
//  Created by admin on 16/6/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "QNNavigationViewController.h"
#import "BaseViewController.h"
@interface QNNavigationViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, assign) BOOL enableRightGesture;
@end

@implementation QNNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarTintColor:HexRGB(0x00aaee)];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 默认为支持右滑反回
    if ([self.topViewController isKindOfClass:[BaseViewController class]]) {
        if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin)]) {
            BaseViewController *vc = (BaseViewController *)self.topViewController;
            self.enableRightGesture = [vc gestureRecognizerShouldBegin];
        }
    }
    
    return self.enableRightGesture;
}


@end
