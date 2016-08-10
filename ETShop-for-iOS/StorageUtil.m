//
//  StorageUtil.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/22.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "StorageUtil.h"

@implementation StorageUtil

+ (void)saveAppCartCookieId:(NSString *)app_cart_cookie_id
{
    [self saveObject:app_cart_cookie_id forKey:kStorageAppCartCookieId];
}
+ (NSString *)getAppCartCookieId
{
    return (NSString *)[self getObjectByKey:kStorageAppCartCookieId];
}

//用户是否已经登录, 由app传user_id和access_token过来
+ (void)saveAccessToken:(NSString *)access_token
{
    [self saveObject:access_token forKey:kStorageAccessToken];
}
+ (NSString *)getAccessToken
{
    return (NSString *)[self getObjectByKey:kStorageAccessToken];
}

//用户信息
+ (void)saveUserId:(NSString *)user_id
{
    [self saveObject:user_id forKey:kStorageUserId];
}
+ (NSNumber *)getUserId
{
    return (NSNumber*)[self getObjectByKey:kStorageUserId];
}
+ (void)saveUserMobile:(NSString *)user_mobile
{
    [self saveObject:user_mobile forKey:kStorageUserMobile];
}
+ (NSString *)getUserMobile
{
    return (NSString *)[self getObjectByKey:kStorageUserMobile];
}
+ (void)saveUserLevel:(NSNumber *)user_level
{
    [self saveObject:user_level forKey:kStorageUserLevel];
}
+ (NSNumber *)getUserLevel
{
    return (NSNumber *)[self getObjectByKey:kStorageUserLevel];
}
+ (void)saveUserLevelLabel:(NSString *)user_level_label
{
    [self saveObject:user_level_label forKey:kStorageUserLevel];
}
+ (NSString *)getUserLevelLabel
{
    return (NSString *)[self getObjectByKey:kStorageUserLevel];
}

//公用的保存和获取本地数据的方法
+ (void)saveObject:(NSObject *)obj forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    [defaults synchronize];//把数据持久化到standardUserDefaults数据库
}
+ (NSObject *)getObjectByKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject *obj = [defaults objectForKey:key];
    
    if (!obj) return nil;
    
    return obj;
}

@end
