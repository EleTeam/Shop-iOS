//
//  HttpClient.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/16.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "HttpClient.h"

@implementation HttpClient

+ (instancetype)sharedInstance
{
    static HttpClient *client;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        client = [[HttpClient alloc] init];
    });
    return client;
}

- (void)request:(NSString *)url
         params:(NSDictionary *)params
           type:(HttpResponseType)type
        success:(void(^)(NSObject *response))success
        failure:(void(^)(NSError *error))failure
{
    //__weak typeof(self) weakSelf = self;
    [self POST:url parameters:params
       success:^(AFHTTPRequestOperation *operation, id response){
           
            #ifdef DEBUG
                //NSLog(@"url:%@\r\nbody:%@", url, response);
            #endif
           
           success(response);
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error){
           failure(error);
       }];
    
}

+ (void)requestJson:(NSString *)url
             params:(NSMutableDictionary *)params
            success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSDictionary *data))success
            failure:(void(^)(NSError *error))failure
{
    if (!params)
        params = [NSMutableDictionary new];
    
    //总是提交客户端类型参数，标明是什么类型的客户端
    [params setObject:kTerminalTypeValue forKey:kTerminalTypeName];
    
    //提交app_cart_cookie_id，不注册用户也能添加产品到购物车
    NSString *app_cart_cookie_id = [StorageUtil getAppCartCookieId];
    NSString *access_token = [StorageUtil getAccessToken];
    NSNumber *user_id = [StorageUtil getUserId];
    //因为NSDictionary setObject: object 不能为 nil，所以这些判断是要的
    if (app_cart_cookie_id == nil)
        app_cart_cookie_id = @"";
    if (access_token == nil)
        access_token = @"";
    if (user_id == nil)
        user_id = @0;
    [params setObject:app_cart_cookie_id forKey:kStorageAppCartCookieId];
    [params setObject:access_token forKey:kStorageAccessToken];
    [params setObject:user_id forKey:kStorageUserId];
    
    [[self sharedInstance] request:url params:params type:HttpResponseType_Json
                                 success:^(NSObject *response){
                                     NSDictionary *dict = (NSDictionary *)response;
                                     BOOL result = [[dict objectForKey:@"status"] boolValue];
                                     NSNumber *code = [dict objectForKey:@"code"];
                                     NSString *message = [dict objectForKey:@"message"];
                                     NSDictionary *data = [dict objectForKey:@"data"];
                                     success(result, code, message, data);
                                 }
                                 failure:failure];
}

@end
