//
//  MacrosHeader.h
//  I51EY.eh
//
//  Created by hui on 16/4/15.
//  Copyright © 2016年 hui. All rights reserved.
//

#ifndef MacrosHeader_h
#define MacrosHeader_h


//字体大小
#define kFont18  [UIFont systemFontOfSize:18]
#define kFont14  [UIFont systemFontOfSize:14]
#define kFont12  [UIFont systemFontOfSize:12]
#define kFont10  [UIFont systemFontOfSize:10]

//圆角
#define kRoundLayer  5.0f


//常用颜色
#define Clear_Color  [UIColor clearColor]
#define Green_Color    [UIColor greenColor]
#define Red_Color    [UIColor redColor]
#define White_Color  [UIColor whiteColor]
#define Black_Color  [UIColor blackColor]
#define Yellow_Color [UIColor yellowColor]
#define Blue_Color [UIColor blueColor]
#define Cyan_Color    [UIColor cyanColor]
#define Orange_Color    [UIColor orangeColor]
#define LightGray_Color    [UIColor lightGrayColor]



//3. 颜色
#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) /255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:(a)]


//背景色
#define Background_Color [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]


//4.加载图片宏：
#define LoadImage(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
//5. NavBar高度
#define NavigationBar_Height 44
//6. 获取系统版本
#define iOS ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//7. 判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//8. 设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]

//9. GCD
#define GCD_Back(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define GCD_Main(block) dispatch_async(dispatch_get_main_queue(),block)



#endif /* MacrosHeader_h */
