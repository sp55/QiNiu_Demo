//
//  QNTokenHelper.h
//  QiNiu_Demo
//
//  Created by admin on 16/6/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNTokenHelper : NSObject


/*
 AccessKey
 SecretKey
 sopeName  空间名
 */
+(NSString *)returnQiniuTokenWithAk:(NSString *)AccessKey
                                 sk:(NSString *)SecretKey
                          scopeName:(NSString *)sopeName;

@end
