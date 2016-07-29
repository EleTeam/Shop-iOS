//
//  OrderModel.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseEntity.h"
#import "OrderEntity.h"
#import "OrderItemEntity.h"
#import "OrderItemAttributeEntity.h"
#import "OrderStatus.h"

@interface OrderModel : BaseEntity

//提交订单
+ (void)addWithPreorderId:(NSString *)preorderId
                addressId:(NSString *)addressId
                   notice:(NSString *)notice
                  success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, OrderEntity *order))success
                  failure:(void(^)(NSError *error))failure;

//获取订单
+ (void)getOrderWithId:(NSString *)orderId
                  success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, OrderEntity *order, NSArray *orderItems))success
                  failure:(void(^)(NSError *error))failure;

//获取订单列表
+ (void)getOrderListWithRoughStatus:(NSString *)roughStatus
                            success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, NSArray *orders)) success
                            failure:(void(^)(NSError *error))failure;


@end
