//
//  UrlMarco.h
//  I51EY.eh
//
//  Created by hui on 16/4/15.
//  Copyright © 2016年 hui. All rights reserved.
//

#ifndef UrlMarco_h
#define UrlMarco_h

#pragma mark - 检验Token是否有效
static NSString  *CheckLoginStatusUrl      = @"/BaseService/CheckLoginStatus";//检验Token是否有效



// NSUserDefaults 实例化
#define QN_UserDefaults [NSUserDefaults standardUserDefaults]

//登陆需要存储的数据
#define kQN_Token         [NSString stringWithFormat:@"%@",[QN_UserDefaults valueForKey:@"Token"]]








#endif /* UrlMarco_h */
