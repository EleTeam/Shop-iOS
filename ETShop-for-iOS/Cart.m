//
//  Cart.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "Cart.h"

@implementation Cart

+ (void)getCart:(void(^)(BOOL status, NSString *message, NSMutableArray *cartItems, NSArray *couponUsers, NSNumber *cart_num, NSNumber *total_price, BOOL is_logged_in))success
        failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlGetCart;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        NSMutableArray *cartItems = [NSMutableArray new];
                        NSMutableArray *couponUsers = [NSMutableArray new];
                        NSNumber *cart_num = nil;
                        NSNumber *total_price = nil;
                        BOOL is_logged_in = NO;
                        NSString *app_cart_cookie_id = nil;
                        if (status) {
                            cartItems = [CartItem mj_objectArrayWithKeyValuesArray:[data objectForKey:@"cartItems"]];
                            couponUsers = [CouponUser mj_objectArrayWithKeyValuesArray:[data objectForKey:@"couponUsers"]];
                            cart_num = [data objectForKey:@"cart_num"];
                            total_price = [data objectForKey:@"total_price"];
                            is_logged_in = [[data objectForKey:@"is_logged_in"] boolValue];
                            
                            //保存app_cart_cookie_id到本地
                            app_cart_cookie_id = [data objectForKey:@"app_cart_cookie_id"];
                            if ([app_cart_cookie_id isKindOfClass:[NSString class]] && app_cart_cookie_id.length > 0) {
                                [StorageUtil saveAppCartCookieId:app_cart_cookie_id];
                            }
                            
                            //购物车项转换为实体
//                            NSMutableArray *cartItemAttrs = [NSMutableArray new];
//                            for (NSDictionary *cartItemDict in cartItemList) {
//                                NSArray *cartItemAttrList = [cartItemDict objectForKey:@"attrList"];
//                                CartItemEntity *cartItem = [[CartItemEntity alloc] initWithDictionary:cartItemDict];
//                                //Product *product = [[Product alloc] initWithDictionary:[cartItemDict objectForKey:@"product"]];
//                                //cartItem.product = product;
//                                
//                                //购物车项的属性
//                                for (NSDictionary *cartItemAttrDict in cartItemAttrList) {
//                                    NSDictionary *productAttrItemDict = [cartItemAttrDict objectForKey:@"attrItem"];
//                                    NSDictionary *productAttrItemValueDict = [cartItemAttrDict objectForKey:@"attrValue"];
//                                    CartItemAttributeEntity *cartItemAttr = [[CartItemAttributeEntity alloc] initWithDictionary:cartItemAttrDict];
//                                    ProductAttributeItemEntity *productAttrItem = [[ProductAttributeItemEntity alloc] initWithDictionary:productAttrItemDict];
//                                    ProductAttributeItemValueEntity *productAttrItemValue = [[ProductAttributeItemValueEntity alloc] initWithDictionary:productAttrItemValueDict];
//                                    cartItemAttr.productAttributeItem = productAttrItem;
//                                    cartItemAttr.productAttributeItemValue = productAttrItemValue;
//                                    [cartItemAttrs addObject:cartItemAttr];
//                                    cartItem.attributes = [cartItemAttrs copy];
//                                }
//                                
//                                [cartItems addObject:cartItem];
//                            }
                            
                            //优惠券转换为实体
                            /*
                            for (NSDictionary *couponUserDict in countUsefulCoupon) {
                                CouponUserEntity *couponUser = [[CouponUserEntity alloc] initWithDictionary:couponUserDict];
                                [couponUsers addObject:couponUser];
                            }
                             */
                        }
                        success(status, message, cartItems, couponUsers, cart_num, total_price, is_logged_in);
                    } failure:^(NSError *error) {
                        failure(error);
                    }];
}

//设置购物车项的数量
+ (void)setCartItemCountWithItemId:(NSNumber *)item_id
                             count:(NSNumber *)count
                           success:(void(^)(BOOL status, NSString *message, NSNumber *cart_num, NSNumber *total_price))success
                           failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:kUrlSetCartItemCountWithItemId, item_id];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                count,      @"count", nil];
    [HttpClient requestJson:url
                     params:params
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        NSNumber *cart_num = nil;
                        NSNumber *total_price = nil;
                        if (status) {
                            cart_num = [data objectForKey:@"cart_num"];
                            total_price = [data objectForKey:@"total_price"];
                        }
                        success(status, message, cart_num, total_price);
                    }
                    failure:failure];
}

//删除购物车项
+ (void)deleteCartItemWithItemId:(NSString *)item_id
                         success:(void(^)(BOOL status, NSString *message, NSNumber *cart_num, NSNumber *total_price))success
                         failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:kUrlCartItemDelete, item_id];
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        NSNumber *cart_num = nil;
                        NSNumber *total_price = nil;
                        if (status) {
                            cart_num = [data objectForKey:@"cart_num"];
                            total_price = [data objectForKey:@"total_price"];
                        }
                        success(status, message, cart_num, total_price);
                    }
                    failure:failure];
}

//选取购物车项
+ (void)selectCartItemWithItemId:(NSString *)item_id
                      is_selected:(NSNumber *)is_selected
                         success:(void(^)(BOOL status, NSString *message, NSNumber *cart_num, NSNumber *total_price))success
                         failure:(void(^)(NSError *error))failure;
{
    NSString *url = [NSString stringWithFormat:kUrlSelectCartItemWithItemId, item_id];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            is_selected,      @"is-selected", nil];
    [HttpClient requestJson:url
                     params:params
                    success:^(BOOL status, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        NSNumber *cart_num = nil;
                        NSNumber *total_price = nil;
                        if (status) {
                            cart_num = [data objectForKey:@"cart_num"];
                            total_price = [data objectForKey:@"totalPrice"];
                        }
                        success(status, message, cart_num, total_price);
                    }
                    failure:failure];
}

@end
