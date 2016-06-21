//
//  QNUploadHelper.m
//  QiNiu_Demo
//
//  Created by admin on 16/6/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "QNUploadHelper.h"
static QNUploadHelper *_sharedInstance ;
@implementation QNUploadHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[QNUploadHelper alloc] init];
    });
    return _sharedInstance;
}

-(id)copyWithZone:(NSZone *)zone{
    return _sharedInstance;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [super allocWithZone:zone];
    });
    return _sharedInstance;
}

@end
