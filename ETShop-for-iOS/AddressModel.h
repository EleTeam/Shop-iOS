//
//  AddressModel.h
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
#import "AddressEntity.h"

@interface AddressModel : BaseModel

//===== 与服务器交互的方法 =====//

/**
 * 添加收货地址
 */
+ (void)addWithAreaId:(NSString *)areaId
            telephone:(NSString *)telephone
               detail:(NSString *)detail
             fullname:(NSString *)fullname
              success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, AddressEntity *address, NSArray *addresses))success
              failure:(void(^)(NSError *error))failure;

//获得地址列表
+ (void)getAddresses:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, NSArray *addresses))success
              failure:(void(^)(NSError *error))failure;

//设置默认地址
+ (void)setDefaultWithId:(NSString *)addressId
              success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, AddressEntity *address, NSArray *addresses))success
              failure:(void(^)(NSError *error))failure;

@end
