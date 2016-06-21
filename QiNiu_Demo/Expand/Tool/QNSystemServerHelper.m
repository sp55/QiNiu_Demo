//
//  QNSystemServerHelper.m
//  QiNiu_Demo
//
//  Created by admin on 16/6/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "QNSystemServerHelper.h"
#import "QNUploadHelper.h"
@implementation QNSystemServerHelper
//压缩上传图片的大小比例
+ (UIImage*)originImage:(UIImage *)image
            scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}
//上传单张图片
+ (void)uploadImage:(UIImage *)image
           progress:(QNUpProgressHandler)progress
            success:(void (^)(NSString *url))success
            failure:(void (^)())failure{
        
        UIImage *sizedImage = [self originImage:image scaleToSize:CGSizeMake(1000, 1000)];
        NSData *data = UIImageJPEGRepresentation(sizedImage, 0.3);
        if (!data) {
            if (failure) {
                failure();
            }
            return;
        }
        
        QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil progressHandler:progress params:nil checkCrc:NO cancellationSignal:nil];
        QNUploadManager *uploadManager = [[QNUploadManager alloc]initWithRecorder:nil];
        [uploadManager putData:data key:nil token:QN_Test_Token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            if (info.statusCode == 200 && resp) {
                NSString *url;
                url = [NSString stringWithFormat:@"%@%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"], resp[@"key"]];
                
                if (success) {
                    success(url);
                }
            }
            else {
                if (failure) {
                    failure();
                }
            }
        } option:opt];

}

//上传多张图片
+ (void)uploadImages:(NSArray *)imageArray progress:(void (^)(CGFloat))progress success:(void (^)(NSArray *))success failure:(void (^)())failure{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    __block float totalProgress = 0.0f;
    __block float partProgress = 1.0f / [imageArray count];
    __block NSUInteger currentIndex = 0;
    
    QNUploadHelper *uploadHelper = [QNUploadHelper sharedInstance];
    __weak typeof(uploadHelper) weakHelper = uploadHelper;
    
    uploadHelper.FailureBlock = ^() {
        failure();
        return;
    };
    uploadHelper.SuccessBlock  = ^(NSString *url) {
        [array addObject:url];
        totalProgress += partProgress;
        progress(totalProgress);
        currentIndex++;
        if ([array count] == [imageArray count]) {
            success([array copy]);
            return;
        }
        else {
            [QNSystemServerHelper uploadImage:imageArray[currentIndex] progress:nil success:weakHelper.SuccessBlock failure:weakHelper.FailureBlock];
        }
    };
    
    [QNSystemServerHelper uploadImage:imageArray[0] progress:nil success:weakHelper.SuccessBlock failure:weakHelper.FailureBlock];
}

// 获取七牛上传成功的成功后服务端返回的url
+ (void)qnUrlKeyArray:(NSArray *)keyArray
              success:(void (^)(NSArray *array))success
              failure:(void (^)())failure{
    NSMutableArray *UrlArray = [[NSMutableArray alloc] init];
    
    __block NSUInteger currentIndex = 0;
    QNUploadHelper *uploadHelper = [QNUploadHelper sharedInstance];
//    __weak typeof(uploadHelper) weakHelper = uploadHelper;
    
    uploadHelper.FailureBlock = ^() {
        failure();
        return;
    };
    uploadHelper.SuccessBlock  = ^(NSString *url) {
        [UrlArray addObject:url];
        currentIndex++;
        if ([UrlArray count] == [keyArray count]) {
            success([UrlArray copy]);
            return;
        }
        else {
//            [QNSystemServerHelper getQiniuUrlkey:url success:weakHelper.SuccessBlock failure:weakHelper.FailureBlock];
        }
    };
    
//    [QNSystemServerHelper getQiniuUrlkey:keyArray[0] success:weakHelper.SuccessBlock failure:weakHelper.FailureBlock];
}

@end
