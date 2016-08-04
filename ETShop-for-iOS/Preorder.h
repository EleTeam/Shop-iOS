//
//  Preorder.h
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
#import "PreorderItem.h"
#import "PreorderItemAttr.h"
#import "Address.h"

@interface Preorder : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *total_count;
@property (nonatomic, strong) NSNumber *total_price;
@property (nonatomic, strong) NSNumber *is_ordered; //是否已经下单
@property (nonatomic, strong) NSNumber *coupon_item_total_price;
@property (nonatomic, strong) NSNumber *origin_total_price;
@property (nonatomic, strong) NSString *area_name;
@property (nonatomic, strong) NSString *area_parent_id;
@property (nonatomic, strong) NSString *area_path_ids;
@property (nonatomic, strong) NSString *area_path_names;
@property (nonatomic, strong) NSString *area_simple_name;
@property (nonatomic, strong) NSString *area_zip_code;
@property (nonatomic, strong) NSString *store_id; //用户选择不同的地址，就会有不同的店铺id
@property (nonatomic, strong) NSString *address_fullname;
@property (nonatomic, strong) NSString *address_telephone;
@property (nonatomic, strong) NSString *address_detail;
@property (nonatomic, strong) NSString *address_id;
@property (nonatomic, strong) NSString *pay_type; //@see Order entity
@property (nonatomic, strong) NSString *rough_pay_type;
@property (nonatomic, strong) NSString *min_total_price_label; //最少支付金额标记
@property (nonatomic, strong) NSString *coupon_item_id;//优惠券id, 对应CouponItem

@property (nonatomic, strong) NSArray *preorderItems;

//===== 与服务器交互的方法 =====//

/**
 * 登陆用户从购物车添加预购订单
 *  只需要访问kUrlPreorderAdd地址即可，不用在本地提交购物车表单
 */
+ (void)add:(void(^)(BOOL status, NSNumber *code, NSString *message, NSNumber *id))success
        failure:(void(^)(NSError *error))failure;

//获取预购订单
+ (void)getWithId:(NSString *)id
                  success:(void(^)(BOOL status, NSNumber *code, NSString *message, Preorder *preorder, Address *address))success
                  failure:(void(^)(NSError *error))failure;

//设置支付方式
+ (void)setPayTypeWithId:(NSNumber *)id
                         payType:(NSNumber *)pay_type
                         success:(void(^)(BOOL status, NSNumber *code, NSString *message, Preorder *preorder))success
                         failure:(void(^)(NSError *error))failure;
@end
