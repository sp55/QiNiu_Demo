//
//  AlertViewHelper.h
//  AlertViewControllerDemo
//
//  Created by admin on 16/4/13.
//  Copyright © 2016年 AlezJi. All rights reserved.
//


//iOS8以上

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



/**
 *  弹框显示的时间，默认1秒
 */

#define kAlertViewShowTime 1.0

/**
 *  检测系统版本
 */

#define iOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *  单个按钮的点击事件
 */
typedef void(^SingleButtonAlertViewBlock)(UIAlertAction *action);

/**
 *  取消按钮和确定按钮
 */
typedef void(^CancelButtonAlertViewBlock)(UIAlertAction *cancelAction);
typedef void(^SureButtonAlertViewBlock)(UIAlertAction *cancelAction);



/**
 *	ActionSheet  多个
 */

typedef void(^ShowActionSheetWithTagBlock)(UIAlertAction *sheetAction, NSInteger selectTag);



@interface AlertViewHelper : NSObject

#pragma mark - Controller
+ (void)showSingleAlertViewWith:(UIViewController *)viewController
                       title:(NSString *)title
                     message:(NSString *)message
                 singleBlock:(SingleButtonAlertViewBlock)block;



+ (void)showCancelAndSureBtnAlertViewWith:(UIViewController *)viewController
                          title:(NSString *)title
                        message:(NSString *)message
                    cancelBlock:(CancelButtonAlertViewBlock)cancelblock
                    sureBlock:(SureButtonAlertViewBlock)sureblock;



+ (void)showActionSheetViewWith:(UIViewController *)viewController
                          title:(NSString *)title
                      selectArr:(NSArray *)selectArr
                      sureBlock:(ShowActionSheetWithTagBlock)selectTagblock;



+ (void)showConfirmAlertViewWith:(UIViewController *)viewController
                           title:(NSString *)title
                         message:(NSString *)message
                     singleBlock:(SureButtonAlertViewBlock)block;



#pragma mark - view
+(void)showAlert:(NSString *)content;
+(void)showAlert:(NSString*)content cancelTitle:(NSString*)title;
+(void)showAlert:(NSString*)content cancelTitle:(NSString*)title delegate:(id)delegate;
+(void)showAlert:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate;
+(void)showAlert:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate viewTag:(NSInteger)viewTag;
+(void)showAlertWithInputNumView:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate;


@end
