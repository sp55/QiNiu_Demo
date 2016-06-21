//
//  BaseViewController.h
//  I51EY.eh
//
//  Created by hui on 16/4/15.
//  Copyright © 2016年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>


//typedef void(^PopBlock)();

@interface BaseViewController : UIViewController




// 默认返回为YES,表示支持右滑返回
- (BOOL)gestureRecognizerShouldBegin;
//Custom TitleView
-(void)setCustomTitle:(NSString *)title;


-(void)needBackAction:(BOOL)isNeed;
-(void)backAction;
-(void)showSVString:(NSString *)showString;
-(void)showSVErrorString:(NSString *)errorString;
- (void)showSVNetWorkError:(NSError*)error;
- (void)showSVServiceFail:(id)resultData;
- (void)showSVServiceSuccess:(id)resultData;
- (void)showSVSuccessWithStatus:(NSString *)successStr;

- (BOOL)checkServiceIfSuccess:(id)resultData;

- (void)addTapGestureOnView:(UIView*)view target:(id)target selector:(SEL)selector;

-(void)pushToNextViewController:(BaseViewController *)viewController;
- (void)dismissSVProgressHUD;
- (void)showSVProgressHUD;
@end
