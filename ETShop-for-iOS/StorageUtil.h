//
//  StorageUtil.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/22.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>

@interface StorageUtil : NSObject

//添加产品到购物车时，服务器会生成唯一的app_cart_cookie_id，必须保存它，每次请求都要提交它
+ (void)saveAppCartCookieId:(NSString *)app_cart_cookie_id;
+ (NSString *)getAppCartCookieId;

//用户是否已经登录, 由app传user_id和access_token过来
+ (void)saveAccessToken:(NSString *)access_token;
+ (NSString *)getAccessToken;

//用户信息
+ (void)saveUserId:(NSNumber *)user_id;
+ (NSNumber *)getUserId;

+ (void)saveUserMobile:(NSString *)user_mobile;
+ (NSString *)getUserMobile;

+ (void)saveUserLevel:(NSNumber *)user_level;
+ (NSNumber *)getUserLevel;

+ (void)saveUserLevelLabel:(NSString *)user_level_label;
+ (NSString *)getUserLevelLabel;

@end
