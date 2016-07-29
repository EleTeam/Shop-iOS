//
//  PreorderModel.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseModel.h"
#import "PreorderEntity.h"
#import "PreorderItemEntity.h"
#import "PreorderItemAttributeEntity.h"
#import "AddressEntity.h"

@interface PreorderModel : BaseModel

//===== 与服务器交互的方法 =====//

/**
 * 登陆用户从购物车添加预购订单
 *  只需要访问kUrlPreorderAdd地址即可，不用在本地提交购物车表单
 */
+ (void)add:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, NSString *preorderId))success
        failure:(void(^)(NSError *error))failure;

//获取预购订单
+ (void)getWithPreorderId:(NSString *)preorderId
                  success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, PreorderEntity *preorder, NSArray *preorderItems, AddressEntity *address))success
                  failure:(void(^)(NSError *error))failure;

//设置支付方式
+ (void)setPayTypeWithPreorderId:(NSString *)preorderId
                         payType:(NSString *)payType
                         success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, PreorderEntity *preorder))success
                         failure:(void(^)(NSError *error))failure;
@end
