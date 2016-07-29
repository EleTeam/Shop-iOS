//
//  storage_macro.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/16.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

//在本地保存用户数据的键

//添加产品到购物车时，服务器会生成唯一的app_cart_cookie_id，必须保存它，每次请求都要提交它
#define kStorageAppCartCookieId     @"app_cart_cookie_id"

//用户是否已经登录, 由app传user_id和access_token过来
#define kStorageAccessToken       @"access_token"

//用户信息
#define kStorageUserId              @"user_id"
#define kStorageUserMobile          @"user_mobile"
#define kStorageUserLevel           @"user_level"