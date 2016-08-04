//
//  Order.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "Order.h"
#import "OrderItem.h"

@implementation Order

// 实现这个方法：告诉MJExtension框架数组里面装的是什么模型
+ (NSDictionary *)objectClassInArray{
    return @{
             @"orderItems" : [OrderItem class]
             };
}

//提交订单
+ (void)addWithPreorderId:(NSNumber *)preorder_id
                addressId:(NSNumber *)address_id
                   notice:(NSString *)notice
                  success:(void(^)(BOOL status, NSNumber *code, NSString *message, Order *order))success
                  failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:kUrlOrderAddWithPreorderId, preorder_id];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   address_id,  @"address_id",
                                   notice,      @"notice", nil];
    [HttpClient requestJson:url
                     params:params
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        Order *order = nil;
                        if (status) {
                            order = [Order mj_objectWithKeyValues:[data objectForKey:@"order"]];
                        }
                        success(status, code, message, order);
                    }
                    failure:failure];
}

//获取订单
+ (void)getOrderWithId:(NSNumber *)id
               success:(void(^)(BOOL status, NSNumber *code, NSString *message, Order *order))success
               failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:kUrlOrderViewWithId, id];
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        Order *order = nil;
                        if (status) {
                            order = [Order mj_objectWithKeyValues:[data objectForKey:@"order"]];
//                            NSDictionary *orderDict = [data objectForKey:@"order"];
//                            NSArray *orderItemList = [data objectForKey:@"orderItemList"];
//                            order = [[OrderEntity alloc] initWithDictionary:orderDict];
//                            for (NSDictionary *itemDict in orderItemList) {
//                                OrderItemEntity *item = [[OrderItemEntity alloc] initWithDictionary:itemDict];
//                                [orderItems addObject:item];
//                            }
                        }
                        success(status, code, message, order);
                    }
                    failure:failure];
}

//获取订单列表
+ (void)getOrderListWithRoughStatus:(NSNumber *)rough_status
             success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray *orders)) success
             failure:(void(^)(NSError *error))failure
{
    NSString *url;
    if ([rough_status isEqual:kRoughStatusPendingPay]) {
        url = kUrlOrderListPendingPay;
    }
    else if ([rough_status isEqual:kRoughStatusDelivering]) {
        url = kUrlOrderListDelivering;
    }
    else if ([rough_status isEqual:kRoughStatusFinished]) {
        url = kUrlOrderListFinished;
    }
    else {
        url = kUrlOrderList;
    }
    
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        NSMutableArray *orders = [NSMutableArray new];
                        if (status) {
                            orders = [Order mj_objectArrayWithKeyValuesArray:[data objectForKey:@"orders"]];
//                            NSArray *list = [data objectForKey:@"orderList"];
//                            for (NSDictionary *orderDict in list) {
//                                NSMutableArray *itemList = [orderDict objectForKey:@"orderItemList"];
//                                NSMutableArray *orderItems = [NSMutableArray new];
//                                
//                                for (NSDictionary *itemDict in itemList) {
//                                    OrderItemEntity *orderItem = [[OrderItemEntity alloc] initWithDictionary:itemDict];
//                                    [orderItems addObject:orderItem];
//                                }
//                                
//                                OrderEntity *order = [[OrderEntity alloc] initWithDictionary:orderDict];
//                                order.orderItems = [orderItems copy];
//                                [orders addObject:order];
//                            }
                        }
                        success(status, code, message, orders);
                    }
                    failure:failure];
}

@end
