//
//  Order.h
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
#import "OrderItem.h"
#import "OrderItemAttr.h"
#import "OrderStatus.h"

@interface Order : NSObject

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *status_union;
@property (nonatomic, copy) NSString *area_name;
@property (nonatomic, copy) NSString *area_parent_id;
@property (nonatomic, copy) NSString *area_path_ids;
@property (nonatomic, copy) NSString *area_path_names;
@property (nonatomic, copy) NSString *area_simple_name;
@property (nonatomic, copy) NSString *area_zip_code;
@property (nonatomic, copy) NSString *store_id; //用户选择不同的地址，就会有不同的店铺id
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, copy) NSNumber *total_count;
@property (nonatomic, copy) NSNumber *total_price;
@property (nonatomic, copy) NSString *address_fullname;
@property (nonatomic, copy) NSString *address_telephone;
@property (nonatomic, copy) NSString *address_detail;
@property (nonatomic, copy) NSString *address_id;
@property (nonatomic, copy) NSString *serial_no;
@property (nonatomic, copy) NSNumber *print_count;
@property (nonatomic, copy) NSNumber *coupon_item_total_price;
@property (nonatomic, copy) NSNumber *origin_total_price;
@property (nonatomic, copy) NSString *notice;
@property (nonatomic, copy) NSNumber *has_paid;
@property (nonatomic, copy) NSString *paid_date;
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, copy) NSString *rough_pay_type;
@property (nonatomic, copy) NSString *op_transaction_id; //在线支付的交易ID
@property (nonatomic, copy) NSString *min_total_price_label; //最少支付金额标记
@property (nonatomic, copy) NSString *create_date_string;

@property (nonatomic, strong) OrderStatus *orderStatus;
@property (nonatomic, strong) NSArray *orderItems; //存放OrderItem

//提交订单
+ (void)addWithPreorderId:(NSNumber *)preorder_id
                addressId:(NSNumber *)address_id
                   notice:(NSString *)notice
                  success:(void(^)(BOOL status, NSNumber *code, NSString *message, Order *order))success
                  failure:(void(^)(NSError *error))failure;

//获取订单
+ (void)getOrderWithId:(NSNumber *)id
                  success:(void(^)(BOOL status, NSNumber *code, NSString *message, Order *order))success
                  failure:(void(^)(NSError *error))failure;

//获取订单列表
+ (void)getOrderListWithRoughStatus:(NSNumber *)rough_status
                            success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray *orders)) success
                            failure:(void(^)(NSError *error))failure;


@end
