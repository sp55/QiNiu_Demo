//
//  StringHelper.m
//  I51EY.eh
//
//  Created by hui on 16/4/29.
//  Copyright © 2016年 hui. All rights reserved.
//

#import "StringHelper.h"

@implementation StringHelper

+(NSAttributedString *)getTwoStringsStrWithLeftFont:(CGFloat)LeftFont
                                leftForegroundColor:(UIColor *)leftForegroundColor
                                         leftString:(NSString *)leftString
                                          rightFont:(CGFloat)righFont
                               rightForegroundColor:(UIColor *)rightForegroundColor
                                        rightString:(NSString *)rightString{
    //左侧的
    NSDictionary *leftDic=@{NSFontAttributeName:[UIFont systemFontOfSize:LeftFont],NSForegroundColorAttributeName:leftForegroundColor};
    NSAttributedString *leftAttStr = [[NSAttributedString alloc] initWithString:leftString attributes:leftDic];
    
    //右侧的
    NSDictionary *rightDic=@{NSFontAttributeName:[UIFont systemFontOfSize:righFont],NSForegroundColorAttributeName:rightForegroundColor};
    NSAttributedString *rightAttStr = [[NSAttributedString alloc] initWithString:rightString attributes:rightDic];
    
    
    //拼接一下
    NSMutableAttributedString *mAttSting =[[NSMutableAttributedString alloc] initWithAttributedString:leftAttStr];
    [mAttSting appendAttributedString:rightAttStr];
    
    
    //返回
    NSAttributedString *totalAttStr=[[NSAttributedString alloc]initWithAttributedString:mAttSting];
    return totalAttStr;
}

#pragma mark - 年月日时分秒
+ (NSString *)currentTimeWithYMDHMS
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
    return currentTime;
}
+ (NSString *)currentTimeWithYMD
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
    return currentTime;
}

+(NSString*)getMDByYMDHMS:(NSString *)YMDHMS
{
    NSDateFormatter *dateFormter = [[NSDateFormatter alloc]init];
    [dateFormter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormter dateFromString:YMDHMS];
    [dateFormter setDateFormat:@"MM-dd"];
    NSString *dateStr = [dateFormter stringFromDate:date];
    NSArray *timeArr=[dateStr componentsSeparatedByString:@"-"];
    NSString *lastStr=[NSString stringWithFormat:@"%@月%@日",timeArr[0],timeArr[1]];
    return lastStr;
}

+(NSString*)getMDByYMD:(NSString *)YMD
{
    NSDateFormatter *dateFormter = [[NSDateFormatter alloc]init];
    [dateFormter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormter dateFromString:YMD];
    [dateFormter setDateFormat:@"MM月dd日"];
    NSString *dateStr = [dateFormter stringFromDate:date];
    //    NSArray *timeArr=[dateStr componentsSeparatedByString:@"-"];
    //    NSString *lastStr=[NSString stringWithFormat:@"%@月%@日",timeArr[0],timeArr[1]];
    //    return lastStr;
    return dateStr;
}

+(NSString*)getMDHMByYMDHMS:(NSString *)YMDHMS
{
    NSDateFormatter *dateFormter = [[NSDateFormatter alloc]init];
    [dateFormter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormter dateFromString:YMDHMS];
    [dateFormter setDateFormat:@"MM-dd HH:mm"];
    NSString *dateStr = [dateFormter stringFromDate:date];
    //    NSArray *timeArr=[dateStr componentsSeparatedByString:@"-"];
    //    NSString *lastStr=[NSString stringWithFormat:@"%@月%@日",timeArr[0],timeArr[1]];
    //    return lastStr;
    return dateStr;
}


+(NSString *)randomStringWithLength:(NSInteger)len{

    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (NSInteger i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    return randomString;
}

@end
