//
//  HttpClient.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/16.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**
 * 封装AFNetworking框架，更易使用
 */

typedef enum {
    HttpResponseType_Common,
    HttpResponseType_Json,
    HttpResponseType_XML
}HttpResponseType;

@interface HttpClient : AFHTTPRequestOperationManager

//使用单例创建AFHTTPRequestOperationManager，无需重复相同实例，否则http多线程会引起内存问题
+ (instancetype)sharedInstance;

- (void)request:(NSString *)url
         params:(NSDictionary *)params
           type:(HttpResponseType)type
        success:(void(^)(NSObject *response))success
        failure:(void(^)(NSError *error))failure;

+ (void)requestJson:(NSString *)url
             params:(NSDictionary *)params
            success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data))success
            failure:(void(^)(NSError *error))failure;
@end
