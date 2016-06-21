//
//  QNUploader.m
//  QiNiu_Demo
//
//  Created by admin on 16/6/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "QNUploader.h"


@interface QNUploader ()
@property (nonatomic, strong) QNUploadManager *upmanager;
@property (nonatomic, strong) NSMutableDictionary *flagDic;
@property (nonatomic, strong) NSMutableArray *uploadTaskArr;
@property (nonatomic, strong) NSMutableDictionary *uploadingTaskDic;
@end

@implementation QNUploader
+(instancetype)defaultUploader{
    
    static QNUploader *uploader= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uploader = [[self alloc]init];
    });
    return uploader;
}
- (void)uploadWithFileurl:(NSURL *)fileurl
               bucketType:(NSString *)bucket{
    
    if ([self fileWithFileUrl:fileurl]) {
        //任务已经存在 继续上传
        [self continueUploadWithFileUrl:fileurl];
        return;
    }
//    //请求token、key
//    [[RAYHttpAPI defaultAPI] get:RAYHttpPathQiniuToken
//                   urlParameters:@{@"bucket":bucket,
//                                   @"extname":[fileurl pathExtension],
//                                   @"from":@"ios"
//                                   }
//               completionHandler:^(id jsonObject, NSError *error) {
//                   if ([RAYHttpAPI dealWithError:error StatueCode:jsonObject]) {
//                       return ;
//                   }
//                   NSDictionary *dataDic = jsonObject[@"data"];
//                   NSString *token = [dataDic objectForKey:@"token"];
//                   NSString *filenameOnQiniu = [dataDic objectForKey:@"filename"];
//                   [self uploadDataWithFileUrl:fileurl withKey:filenameOnQiniu token:token];
//                   
//                   QNUploadFile *file = [[QNUploadFile alloc]init];
//                   file.fileurl = fileurl;
//                   file.key = filenameOnQiniu;
//                   file.token = token;
//                   //加入到任务数组中
//                   [self.uploadTaskArr addObject:file];
//               }];
    
}

- (void)uploadDataWithFileUrl:(NSURL *)fileUrl
                      withKey:(NSString *)key
                        token:(NSString *)token{
    [self uploadObject:fileUrl withKey:key token:token];
    
}

- (void)uploadObject:(NSURL*)fileurl
             withKey:(NSString *)key
               token:(NSString *)token{
    
    [self.flagDic setValue:@(0) forKey:fileurl.path];
    //option
    QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil progressHandler: ^(NSString *key, float percent) {
        [self.uploadingTaskDic setObject:@(percent) forKey:fileurl.path];
        if (percent >= 1) {
            [self.flagDic setValue:@(1) forKey:fileurl.path];
            [self.flagDic removeObjectForKey:fileurl.path];
            [self removeTaskWithFileurl:fileurl];
            //[self.uploadingTaskDic removeObjectForKey:fileurl.path];
            
            if ([self.delegate respondsToSelector:@selector(uploadFinish)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate uploadFinish];
                });
            }else{
                NSLog(@"WORNING: 代理方法：(uploadFinish)未实现");
            }
        }
        // NSLog(@"---***---上传进度：%f-----*",percent);
        if ([self.delegate respondsToSelector:@selector(uploadingProgress:fileUrl:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate uploadingProgress:percent fileUrl:fileurl];
            });
        }else{
            NSLog(@"WORNING: 代理方法：(uploadingProgress:fileUrl:)未实现");
        }
        
    } params:nil checkCrc:NO cancellationSignal: ^BOOL () {
        return [[self.flagDic objectForKey:fileurl.path]boolValue];
    }];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if ([fileurl isKindOfClass:[NSURL class]]) {
        
        [self.upmanager putFile:[(NSURL*)fileurl path]
                            key:key
                          token:token
                       complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                           [self uploadWithQNResponseInfo:info key:key resp:resp fileUrl:fileurl];
                       } option:opt];
    }
}

- (void)uploadWithQNResponseInfo:(QNResponseInfo*)info key:(NSString *)key resp:(NSDictionary *)resp fileUrl:url{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([self.delegate respondsToSelector:@selector(uploadWithQNResponseInfo:fileUrl:resp:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate uploadWithQNResponseInfo:info
                                            fileUrl:url
                                               resp:resp];
        });
        
    }else{
        NSLog(@"WORNING: 代理方法：(uploadWithQNResponseInfo:fileUrl:resp:)未实现");
    }
}

//lazy upmanager
-(QNUploadManager *)upmanager{
    if (_upmanager==nil) {
        NSError *error = nil;
        QNFileRecorder *recorder = [QNFileRecorder fileRecorderWithFolder:[NSTemporaryDirectory() stringByAppendingString:@"RAYUploadFileRecord"] error:&error];
        _upmanager = [[QNUploadManager alloc]initWithRecorder:recorder];
    }
    return _upmanager;
}

-(NSMutableDictionary *)flagDic{
    if (_flagDic == nil) {
        _flagDic = [[NSMutableDictionary alloc]init];
    }
    return _flagDic;
}

-(NSMutableArray *)uploadTaskArr{
    if (_uploadTaskArr == nil) {
        _uploadTaskArr = [[NSMutableArray alloc]init];
    }
    return _uploadTaskArr;
}

-(NSMutableDictionary *)uploadingTaskDic{
    if (_uploadingTaskDic == nil) {
        _uploadingTaskDic = [[NSMutableDictionary alloc]init];
    }
    return _uploadingTaskDic;
}

//取消上传
- (void)cancelUploadWithFileUrl:(NSURL *)url{
    [self.flagDic setObject:@1 forKey:url.path];
}

//取消所有上传
- (void)cancelAllTask{
    for (NSString *key in self.flagDic.allKeys) {
        [self.flagDic setObject:@1 forKey:key];
    }
    
}

//继续上传
- (void)continueUploadWithFileUrl:(NSURL *)url{
    [self.flagDic setObject:@0 forKey:url.path];
    QNUploadFile *file = [self fileWithFileUrl:url];
    if (file == nil) {
        return;
    }
    NSLog(@"继续上传%@,%@",file.key,file.token);
    [self uploadObject:file.fileurl withKey:file.key token:file.token];
}

- (void)continueAllTask{
    for (NSString *key in self.flagDic.allKeys) {
        NSURL *url = [NSURL fileURLWithPath:key];
        [self continueUploadWithFileUrl:url];
    }
    
}

- (QNUploadFile *)fileWithFileUrl:(NSURL*)url{
    
    for (QNUploadFile *file in self.uploadTaskArr) {
        if ([file.fileurl isEqual:url]) {
            return file;
        }
    }
    NSLog(@"Error：任务不存在或已经结束");
    return nil;
}

- (void)removeTaskWithFileurl:(NSURL *)url{
    QNUploadFile *file = [self fileWithFileUrl:url];
    if (file == nil) {
        return;
    }
    [self.uploadTaskArr removeObject:file];
}

- (float)uploadPersentOfFileUrl:(NSURL *)fileUrl{
    NSNumber *persent = [self.uploadingTaskDic objectForKey:fileUrl.path];
    return persent.floatValue;
}

- (BOOL)isUploadingOfFileurl:(NSURL *)fileUrl{
    if ([[self.flagDic objectForKey:fileUrl.path] isEqual:@0]) {
        return YES;
    }
    return NO;
}


@end
