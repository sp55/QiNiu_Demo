//
//  QNUploadHelper.h
//  QiNiu_Demo
//
//  Created by admin on 16/6/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNUploadHelper : NSObject
/**
 *  成功回调
 */
@property (copy, nonatomic) void (^SuccessBlock)(NSString *);

/**
 *  失败回调
 */
@property (copy, nonatomic) void (^FailureBlock)();

+ (instancetype)sharedInstance;

@end
