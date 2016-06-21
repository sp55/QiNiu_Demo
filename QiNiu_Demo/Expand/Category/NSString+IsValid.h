//
//  NSString+IsValid.h
//  I51EY.eh
//
//  Created by admin on 16/4/18.
//  Copyright © 2016年 hui. All rights reserved.
//

//http://my.oschina.net/sayonala/blog/201267?p=1
//ios正则表达式


#import <Foundation/Foundation.h>

@interface NSString (IsValid)


/**
 *	银行卡
 */
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;

/**
 *	身份证
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;



/**
 *	邮箱
 */
+ (BOOL) validateEmail:(NSString *)email;


/**
 *	手机号验证
 */
+ (BOOL)validateMobile:(NSString *)mobileNum;

/*
 车牌号验证   （不含省）
 */
+ (BOOL) validateCarcode:(NSString *)carcode;

@end
