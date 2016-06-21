//
//  UIView+RoundLayer.h
//  I51EY.eh
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RoundLayer)

//圆角
-(void)roundLayerWithKRadiusLayer;


//圆角
-(void)roundLayerWithRadius:(CGFloat)radius;

//带边框颜色
-(void)roundLayerWithRadius:(CGFloat)radius borderColor:(UIColor *)borderColor;

@end
