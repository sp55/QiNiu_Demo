//
//  StringHelper.h
//  I51EY.eh
//
//  Created by hui on 16/4/29.
//  Copyright © 2016年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringHelper : NSObject


//根据字体大小 颜色 和文本 返回  两天数据拼接一下 100%
+(NSAttributedString *)getTwoStringsStrWithLeftFont:(CGFloat)LeftFont
                                leftForegroundColor:(UIColor *)leftForegroundColor
                                         leftString:(NSString *)leftString
                                          rightFont:(CGFloat)righFont
                               rightForegroundColor:(UIColor *)rightForegroundColor
                                        rightString:(NSString *)rightString;



#pragma mark - 当前时间年月日时分秒
+ (NSString *)currentTimeWithYMDHMS;
+ (NSString *)currentTimeWithYMD;
+(NSString*)getMDByYMDHMS:(NSString *)YMDHMS;
+(NSString*)getMDByYMD:(NSString *)YMD;
+(NSString*)getMDHMByYMDHMS:(NSString *)YMDHMS;


#pragma mark - 随机字符串
+(NSString *)randomStringWithLength:(NSInteger)len;

@end
