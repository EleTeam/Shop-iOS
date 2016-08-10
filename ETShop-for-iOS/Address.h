//
//  Address.h
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
#import "Area.h"

@interface Address : NSObject

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *fullname;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSNumber *is_default;

@property (nonatomic, strong) Area *area;

//===== 与服务器交互的方法 =====//

/**
 * 添加收货地址
 */
+ (void)addWithAreaId:(NSNumber *)area_id
            telephone:(NSString *)telephone
               detail:(NSString *)detail
             fullname:(NSString *)fullname
              success:(void(^)(BOOL status, NSNumber *code, NSString *message, Address *address, NSArray *addresses))success
              failure:(void(^)(NSError *error))failure;

//获得地址列表
+ (void)getAddresses:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray *addresses))success
              failure:(void(^)(NSError *error))failure;

//设置默认地址
+ (void)setDefaultWithId:(NSNumber *)id
              success:(void(^)(BOOL status, NSNumber *code, NSString *message, Address *address, NSArray *addresses))success
              failure:(void(^)(NSError *error))failure;

@end
