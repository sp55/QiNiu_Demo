//
//  BaseViewController.m
//  I51EY.eh
//
//  Created by hui on 16/4/15.
//  Copyright © 2016年 hui. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (BOOL)gestureRecognizerShouldBegin {
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self dismissSVProgressHUD];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self needBackAction:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRGB:0x218ad5]];
    
    self.view.backgroundColor =RGB(241, 241, 246);
    
}
-(void)needBackAction:(BOOL)isNeed
{
    if (isNeed) {
        UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_back-n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
        self.navigationItem.leftBarButtonItem = backItem;
    }else{
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    }
}
#pragma mark - custom title
-(void)setCustomTitle:(NSString *)title
{
    UILabel *customLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
    customLabel.textAlignment = NSTextAlignmentCenter;
    customLabel.textColor = [UIColor whiteColor];
    customLabel.font = [UIFont systemFontOfSize:16];
    customLabel.text = title;
    self.navigationItem.titleView = customLabel;
}
#pragma mark  - back
-(void)backAction
{
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}



-(void)showSVErrorString:(NSString *)errorString
{
    [SVProgressHUD showErrorWithStatus:errorString];
    [self performSelector:@selector(dismissSVProgressHUD) withObject:nil afterDelay:2];
    
    
}
-(void)dismissSVProgressHUD{
    [SVProgressHUD dismiss];
}
- (void)showSVProgressHUD {
    [SVProgressHUD show];
}

-(void)showSVString:(NSString *)showString
{
    [SVProgressHUD showInfoWithStatus:showString];
    [self performSelector:@selector(dismissSVProgressHUD) withObject:nil afterDelay:2];
    
}


- (void)showSVSuccessWithStatus:(NSString *)successStr{
    [SVProgressHUD showSuccessWithStatus:successStr];
    [self performSelector:@selector(dismissSVProgressHUD) withObject:nil afterDelay:2];
}

- (void)showSVNetWorkError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:error.description];
    [self performSelector:@selector(dismissSVProgressHUD) withObject:nil afterDelay:1];
    
}

- (void)showSVServiceFail:(id)resultData{
    [SVProgressHUD showInfoWithStatus:resultData[@"msg"]];
    [self performSelector:@selector(dismissSVProgressHUD) withObject:nil afterDelay:1];
    
}

- (void)showSVServiceSuccess:(id)resultData{
    [SVProgressHUD showSuccessWithStatus:resultData[@"msg"]];
    [self performSelector:@selector(dismissSVProgressHUD) withObject:nil afterDelay:1];
    
}

- (BOOL)checkServiceIfSuccess:(id)resultData{
    return [resultData[@"code"]boolValue];
}

- (void)addTapGestureOnView:(UIView*)view target:(id)target selector:(SEL)selector{
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    gest.numberOfTapsRequired = 1;
    gest.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:gest];
}

-(void)pushToNextViewController:(BaseViewController *)viewController
{
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
