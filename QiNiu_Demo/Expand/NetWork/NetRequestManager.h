//
//  NetRequestManager.h
//  afne
//
//  Created by hui on 16/4/13.
//  Copyright © 2016年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestManager : NSObject

+ (NetRequestManager *)shareManager;


/** POST   */
- (void)postUrl:(NSString *)urlString
     parameters:(id)parametes
        success:(void(^)(id responseObject))success
        failure:(void(^)(id error))failure;

/**  GET  */
- (void)getUrl:(NSString *)urlString
    parameters:(id)parameters
       success:(void(^)(id responseObject))success
       failure:(void(^)(id error))failure;


@end
