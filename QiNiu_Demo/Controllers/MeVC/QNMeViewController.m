//
//  QNMeViewController.m
//  QiNiu_Demo
//
//  Created by admin on 16/6/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "QNMeViewController.h"

@interface QNMeViewController ()

@property(strong,nonatomic)UIImageView *imgView;

@end

@implementation QNMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self needBackAction:NO];
    [self setCustomTitle:@"我的"];

    
    [self initUI];
}
#pragma mark - initUI
-(void)initUI
{
    //这是上传上去的图片
    self.imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, (kScreenHeight-64-49))];
    self.imgView.backgroundColor = Red_Color;
    //http://7xv8pg.com1.z0.glb.clouddn.com/gyy_91
    //http://7xv8pg.com1.z0.glb.clouddn.com/gyy_92
    //http://7xv8pg.com1.z0.glb.clouddn.com/gyy_93
    //http://7xv8pg.com1.z0.glb.clouddn.com/gyy_94
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://7xv8pg.com1.z0.glb.clouddn.com/gyy_93"]];
    [self.view addSubview:self.imgView];
    
    
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
