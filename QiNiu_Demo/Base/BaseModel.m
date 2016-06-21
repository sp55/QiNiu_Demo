//
//  BaseModel.m
//  I51EY.eh
//
//  Created by hui on 16/4/15.
//  Copyright © 2016年 hui. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key{
    if (value == nil) {
        [super setValue:@"" forKey:key];
    }
    else if ([value isKindOfClass:[NSNull class]]){
        [super setValue:@"" forKey:key];
    }
 
    else{
        [super setValue:value forKey:key];
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
@end
