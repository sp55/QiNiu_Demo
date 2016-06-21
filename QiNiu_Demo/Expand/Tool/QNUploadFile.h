//
//  QNUploadFile.h
//  QiNiu_Demo
//
//  Created by admin on 16/6/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNUploadFile : NSObject

@property (nonatomic, strong) NSURL* fileurl;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *token;

@end
