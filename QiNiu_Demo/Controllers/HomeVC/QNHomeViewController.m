//
//  QNHomeViewController.m
//  QiNiu_Demo
//
//  Created by admin on 16/6/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "QNHomeViewController.h"
#import "QNTokenHelper.h"
@interface QNHomeViewController ()

@property (nonatomic,strong) QNUploadManager *upManager;//文件管理类  是个单例

@end

@implementation QNHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
//    DLog(@"---%.f",time);

    [self needBackAction:NO];
    [self setCustomTitle:@"首页"];
    [self initUI];
}
#pragma mark - initUI
-(void)initUI
{
    //文件管理类
    self.upManager = [[QNUploadManager alloc] init];
#pragma mark - 上传  upload
    NSArray *uploadArrs=@[@"上传文字",@"上传多张图片",@"上传:自定义参数",@"上传单张图片",@"上传本地音频MP3",@"上传本地视频MP4"];
    for (NSInteger i=0; i<uploadArrs.count; i++) {
        UIButton *uploadBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        uploadBtn.frame = CGRectMake(20, 84+60*i, kScreenWidth/2-30, 40);
        [uploadBtn addTarget:self action:@selector(uploadAction:) forControlEvents:UIControlEventTouchUpInside];
        uploadBtn.tag = 100+i;
        [uploadBtn setTitle:uploadArrs[i] forState:UIControlStateNormal];
        [uploadBtn setBackgroundColor:Red_Color];
        [uploadBtn setTitleColor:White_Color forState:UIControlStateNormal];
        [self.view addSubview:uploadBtn];

    }
    
#pragma mark - 下载  download
    NSArray *downloadArrs=@[@"下载文字",@"下载多张图片",@"下载:自定义参数",@"下载单张图片",@"下载音频MP3",@"下载视频MP4"];
    for (NSInteger i=0; i<downloadArrs.count; i++) {
        UIButton *downloadBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        downloadBtn.frame = CGRectMake(kScreenWidth/2, 84+60*i, kScreenWidth/2-30, 40);
        [downloadBtn addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
        downloadBtn.tag = 200+i;
        [downloadBtn setTitle:downloadArrs[i] forState:UIControlStateNormal];
        [downloadBtn setBackgroundColor:Red_Color];
        [downloadBtn setTitleColor:White_Color forState:UIControlStateNormal];
        [self.view addSubview:downloadBtn];
        
    }
    
    
}
#pragma mark - upload上传
-(void)uploadAction:(UIButton*)btn
{
    if (btn.tag==100) {//上传文字
#pragma mark -上传文字
        NSData *data = [@"uploadBtn1Action" dataUsingEncoding : NSUTF8StringEncoding];
        [self.upManager putData:data key:@"uploadBtn100Action" token:QN_Test_Token
                       complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                           NSLog(@"info--->%@", info);
                           NSLog(@"状态码-->%d", info.statusCode);
                           NSLog(@"resp--->%@", resp);
                       } option:nil];
    }else if (btn.tag==101){//上传图片数组
#pragma mark -上传图片数组
        NSMutableArray *imgsArr=[NSMutableArray array];
        NSArray *imgNamesArr=@[@"ns_1.jpg",@"ns_2.jpg",@"ns_3.jpg",@"ns_4.jpg"];
        for (NSInteger i=0; i<imgNamesArr.count; i++) { //imgsArr
            [imgsArr addObject:[UIImage imageNamed:imgNamesArr[i]]];
        }
        
        NSMutableArray *dataArr=[NSMutableArray array]; //dataArr
        for (UIImage *img in imgsArr) {
            NSData *data=UIImagePNGRepresentation(img);
            [dataArr addObject:data];
            
        }
        NSMutableArray *urlArr=[NSMutableArray array]; //urlArr
        NSInteger i=90;
        for (NSData *data in dataArr) {
            i++;
            [self.upManager putData:data key:[NSString stringWithFormat:@"gyy_%ld",i] token:QN_Test_Token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                NSLog(@"info--->%@", info);
                NSLog(@"状态码-->%d", info.statusCode);
                NSLog(@"resp--->%@", resp);
                if (resp!=nil) {
                    DLog(@"====%@",[resp objectForKey:@"key"]);
                    [urlArr addObject:[resp objectForKey:@"key"]];
                }
            } option:nil];
        }
    }else if (btn.tag==102){//上传
#pragma mark -上传:自定义参数
        NSData *data = [@"uploadBtn103Action_Test_Custom"  dataUsingEncoding : NSUTF8StringEncoding];
        QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:@"text/plain"progressHandler:nil params:@{ @"x:foo":@"fooval" } checkCrc:YES cancellationSignal:nil];
        [self.upManager putData:data key:@"uploadBtn102Action" token:QN_Test_Token
                       complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                           NSLog(@"info-->%@", info);
                           NSLog(@"状态码-->%d", info.statusCode);
                           NSLog(@"resp--->%@", resp);
                       } option:opt];
    }else if (btn.tag==103){//上传单张图片
#pragma mark -上传单张图片
        //单张图片文件名
        NSString *fileName_Key = [NSString stringWithFormat:@"%@_%@.jpg", [StringHelper currentTimeWithYMDHMS], [StringHelper randomStringWithLength:8]];
        //路径
        UIImage *img=[UIImage imageNamed:@"ns_2.jpg"];
        NSData *data=UIImageJPEGRepresentation(img, 0.5);
        
        QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
            NSLog(@"percent == %.2f", percent);
        } params:nil checkCrc:NO cancellationSignal:nil];
        
        [self.upManager putData:data key:fileName_Key token:QN_Test_Token
                       complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                           NSLog(@"info-->%@", info);
                           NSLog(@"状态码-->%d", info.statusCode);
//                           NSLog(@"resp--->%@", resp);
                       } option:opt];
    }else if (btn.tag==104){//上传一段本地音频MP3
#pragma mark -上传一段本地音频MP3
        //文件名
        NSString *MP3_Path =[[NSBundle mainBundle]pathForResource:@"five_circles" ofType:@"mp3"];
        NSData *data = [NSData dataWithContentsOfFile:MP3_Path];
        QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
            NSLog(@"percent == %.2f", percent);
        } params:nil checkCrc:NO cancellationSignal:nil];
        [self.upManager putData:data key:[NSString stringWithFormat:@"%@%@.mp3",[StringHelper currentTimeWithYMDHMS],[StringHelper randomStringWithLength:4]] token:QN_Test_Token
                       complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                           //                           NSLog(@"info-->%@", info);
                           NSLog(@"状态码-->%d", info.statusCode);
                           //                           NSLog(@"resp--->%@", resp);
                       } option:opt];
    }else if (btn.tag==105){//上传一段本地视频MP4
#pragma mark -上传一段本地视频MP4
        //文件名
        NSString *MP3_Path =[[NSBundle mainBundle]pathForResource:@"cloudy_night" ofType:@"mp4"];
        NSData *data = [NSData dataWithContentsOfFile:MP3_Path];
        QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
            NSLog(@"percent == %.2f", percent);
        } params:nil checkCrc:NO cancellationSignal:nil];
        [self.upManager putData:data key:[NSString stringWithFormat:@"%@%@.mp4",[StringHelper currentTimeWithYMDHMS],[StringHelper randomStringWithLength:5]] token:QN_Test_Token
                       complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                           //                           NSLog(@"info-->%@", info);
                           NSLog(@"状态码-->%d", info.statusCode);
                           //                           NSLog(@"resp--->%@", resp);
                       } option:opt];
    }

}

#pragma mark - download下载
-(void)downloadAction:(UIButton*)btn
{
    if (btn.tag==200) {//下载文字 //http://7xv8pg.com1.z0.glb.clouddn.com/uploadBtn1Action
        DLog(@"200=========");
        
#pragma mark -下载文字
        }else if (btn.tag==201){//下载图片数组//http://7xv8pg.com1.z0.glb.clouddn.com/gyy_92
#pragma mark -下载图片数组
          }else if (btn.tag==202){//下载
#pragma mark -下载:自定义参数
         }else if (btn.tag==203){//下载单张图片//http://7xv8pg.com1.z0.glb.clouddn.com/gyy_91
#pragma mark -下载单张图片
          }else if (btn.tag==204){//下载音频MP3//http://7xv8pg.com1.z0.glb.clouddn.com/2016-06-11_21%3A22%3A37dgMV.mp3
              DLog(@"204=========");
#pragma mark -下载音频MP3
        }else if (btn.tag==205){//下载视频MP4//http://7xv8pg.com1.z0.glb.clouddn.com/2016-06-21-20-32-063oS8m.mp4
#pragma mark -上下载视频MP4
        }
    
}



@end
