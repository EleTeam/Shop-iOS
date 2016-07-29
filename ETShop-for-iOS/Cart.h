//
//  Cart.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "CartItem.h"
#import "CartItemAttr.h"
#import "Product.h"
#import "ProductAttrItem.h"
#import "ProductAttrItemValue.h"
#import "CouponUser.h"

@interface Cart : NSObject

@property (nonatomic, copy) NSNumber *id;

//===== 与服务器交互的方法 =====//

//获得购物车的项, 包括对应的产品属性
+ (void)getCart:(void(^)(BOOL status, NSString *message, NSMutableArray *cartItems, NSArray *couponUsers, NSNumber *cart_num, NSNumber *total_price, BOOL is_logged_in))success
           failure:(void(^)(NSError *error))failure;

//设置购物车项的数量
+ (void)setCartItemCountWithItemId:(NSNumber *)item_id
                             count:(NSNumber *)count
                           success:(void(^)(BOOL status, NSString *message, NSNumber *cart_num, NSNumber *total_price))success
                           failure:(void(^)(NSError *error))failure;

//删除购物车项
+ (void)deleteCartItemWithItemId:(NSNumber *)item_id
                           success:(void(^)(BOOL status, NSString *message, NSNumber *cart_num, NSNumber *total_price))success
                           failure:(void(^)(NSError *error))failure;

//选取购物车项
+ (void)selectCartItemWithItemId:(NSNumber *)item_id
                      is_selected:(NSNumber *)is_selected
                         success:(void(^)(BOOL status, NSString *message, NSNumber *cart_num, NSNumber *total_price))success
                         failure:(void(^)(NSError *error))failure;

@end
