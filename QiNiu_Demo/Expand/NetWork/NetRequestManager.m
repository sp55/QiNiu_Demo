//
//  NetRequestManager.m
//  afne
//
//  Created by hui on 16/4/13.
//  Copyright © 2016年 hui. All rights reserved.
//

#import "NetRequestManager.h"

@implementation NetRequestManager


+ (NetRequestManager *)shareManager
{
    static NetRequestManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (manager == nil) {
            manager =[[NetRequestManager alloc]init];
        }
    });
    return manager;
}

-(AFHTTPSessionManager *)sessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setTimeoutInterval:60];
    
    return manager;
    
}

#pragma mark - Post
-(void)postUrl:(NSString *)urlString parameters:(id)parametes success:(void (^)(id))success failure:(void (^)(id))failure
{
    
    [[self sessionManager] POST:urlString parameters:parametes progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
}


#pragma mark - Get
- (void)getUrl:(NSString *)urlString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(id))failure
{
    
    [[self sessionManager] GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            success(responseObject);
        }
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}




@end
