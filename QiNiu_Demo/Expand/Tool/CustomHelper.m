//
//  CustomHelper.m
//  I51EY.eh
//
//  Created by hui on 16/4/15.
//  Copyright © 2016年 hui. All rights reserved.
//

#import "CustomHelper.h"

@implementation CustomHelper

+(BOOL)isNetWorking
{
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    if (status == RealStatusNotReachable)
    {
        DLog(@"没有网");
        return NO;
    }
    
    if (status == RealStatusViaWiFi)
    {
        DLog(@"有WiFi");
        
        return YES;
    }
    
    if (status == RealStatusViaWWAN)
    {
        DLog(@"有WLAN");
        
        return YES;
    }
    return NO;
    
}



@end
