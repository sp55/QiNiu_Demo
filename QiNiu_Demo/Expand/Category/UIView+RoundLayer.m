//
//  UIView+RoundLayer.m
//  I51EY.eh
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 hui. All rights reserved.
//

#import "UIView+RoundLayer.h"

@implementation UIView (RoundLayer)

-(void)roundLayerWithKRadiusLayer
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = kRoundLayer;
}

-(void)roundLayerWithRadius:(CGFloat)radius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}
-(void)roundLayerWithRadius:(CGFloat)radius borderColor:(UIColor *)borderColor{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = borderColor.CGColor;
}

@end
