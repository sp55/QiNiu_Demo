//
//  AlertViewHelper.m
//  AlertViewControllerDemo
//
//  Created by admin on 16/4/13.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "AlertViewHelper.h"

@implementation AlertViewHelper

#pragma mark - Controller
+ (void)showSingleAlertViewWith:(UIViewController *)viewController
                       title:(NSString *)title
                     message:(NSString *)message
                 singleBlock:(SingleButtonAlertViewBlock)block
{
    if (iOS_VERSION >= 8.0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *singleAction  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            block(action);
        }];
        [alertController addAction:singleAction];

        [viewController presentViewController:alertController animated:YES completion:nil];
        
        //如果没有按钮，自动延迟消失
        if (title == nil) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:kAlertViewShowTime];
        }
    }
}

+ (void)showConfirmAlertViewWith:(UIViewController *)viewController
                          title:(NSString *)title
                        message:(NSString *)message
                    singleBlock:(SureButtonAlertViewBlock)block
{
    if (iOS_VERSION >= 8.0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *singleAction  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            block(action);
        }];
        [alertController addAction:singleAction];
        
        [viewController presentViewController:alertController animated:YES completion:nil];
        
        //如果没有按钮，自动延迟消失
        if (title == nil) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:kAlertViewShowTime];
        }
    }
}

+ (void)showCancelAndSureBtnAlertViewWith:(UIViewController *)viewController
                                    title:(NSString *)title
                                  message:(NSString *)message
                              cancelBlock:(CancelButtonAlertViewBlock)cancelblock
                                sureBlock:(SureButtonAlertViewBlock)sureblock{

    if (iOS_VERSION >= 8.0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            cancelblock(action);
        }];
        [alertController addAction:cancelAction];
        UIAlertAction *sureAction  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            sureblock(action);
        }];
        [alertController addAction:sureAction];
        [viewController presentViewController:alertController animated:YES completion:nil];
        //如果没有按钮，自动延迟消失
        if (title == nil) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:kAlertViewShowTime];
        }

    }

}

+ (void)showActionSheetViewWith:(UIViewController *)viewController
                          title:(NSString *)title
                      selectArr:(NSArray *)selectArr
                      sureBlock:(ShowActionSheetWithTagBlock)selectTagblock{
    if (iOS_VERSION >= 8.0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (NSInteger i=0; i<selectArr.count; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:selectArr[i]
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               selectTagblock(action,i);
                                                           }];
            [alertController addAction:action];
            
        }
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {
                                                              DLog(@"取消按钮");
                                                          }]];
        [viewController presentViewController:alertController animated:YES completion:nil];
        
    }
    
}



+ (void)dismissAlertController:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - view
+(void)showAlert:(NSString*)content{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

+(void)showAlert:(NSString*)content cancelTitle:(NSString*)title
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:content delegate:self cancelButtonTitle:title otherButtonTitles: nil];
    [alertView show];
}

+(void)showAlert:(NSString*)content cancelTitle:(NSString*)title delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:content delegate:self cancelButtonTitle:title otherButtonTitles: nil];
    alertView.delegate = delegate;
    [alertView show];
}

+(void)showAlert:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:content message:title delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:okTitle, nil];
    alertView.delegate = delegate;
    [alertView show];
}

+(void)showAlert:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate viewTag:(NSInteger)viewTag
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:okTitle, nil];
    alertView.delegate = delegate;
    alertView.tag = viewTag;
    [alertView show];
}

+(void)showAlertWithInputNumView:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:okTitle, nil];
    alertView.delegate = delegate;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

@end
