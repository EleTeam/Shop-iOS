//
//  Address.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "Address.h"

@implementation Address

/**
 * 添加收货地址
 */
+ (void)addWithAreaId:(NSNumber *)area_id
            telephone:(NSString *)telephone
               detail:(NSString *)detail
             fullname:(NSString *)fullname
              success:(void(^)(BOOL status, NSNumber *code, NSString *message, Address *address, NSArray *addresses))success
              failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlAddressAdd;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   area_id,      @"area_id",
                                   telephone,   @"telephone",
                                   detail,      @"detail",
                                   fullname,    @"fullname", nil];
    [HttpClient requestJson:url
                     params:params
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        Address *address = nil;
                        NSMutableArray *addresses = [NSMutableArray new];
                        if (status) {
                            address = [Address mj_objectWithKeyValues:[data objectForKey:@"address"]];
                            addresses = [Address mj_objectArrayWithKeyValuesArray:[data objectForKey:@"addresses"]];
//                            NSDictionary *addressDict = [data objectForKey:@"address"];
//                            NSArray *addressList = [data objectForKey:@"addressList"];
//                            address = [[AddressEntity alloc] initWithDictionary:addressDict];
//                            for (NSDictionary *addrDict in addressList) {
//                                AddressEntity *addr = [[AddressEntity alloc] initWithDictionary:addrDict];
//                                [addresses addObject:addr];
//                            }
                        }
                        success(status, code, message, address, addresses);
                    }
                    failure:failure];
}

//获得地址列表
+ (void)getAddresses:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray *addresses))success
             failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlAddressGetList;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        NSMutableArray *addresses = [NSMutableArray new];
                        if (status) {
                            addresses = [Address mj_objectArrayWithKeyValuesArray:[data objectForKey:@"addresses"]];
//                            NSArray *addressList = [data objectForKey:@"addressList"];
//                            for (NSDictionary *addressDict in addressList) {
//                                NSDictionary *areaDict = [addressDict objectForKey:@"area"];
//                                AreaEntity *area = [[AreaEntity alloc] initWithDictionary:areaDict];
//                                AddressEntity *address = [[AddressEntity alloc] initWithDictionary:addressDict];
//                                address.area = area;
//                                [addresses addObject:address];
//                            }
                        }
                        success(status, code, message, addresses);
                    }
                    failure:failure];
}

//设置默认地址
+ (void)setDefaultWithId:(NSString *)id
                 success:(void(^)(BOOL status, NSNumber *code, NSString *message, Address *address, NSArray *addresses))success
                 failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:kUrlAddressSetDefaultWithId, id];
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        Address *address = nil;
                        NSMutableArray *addresses = [NSMutableArray new];
                        if (status) {
                            addresses = [Address mj_objectArrayWithKeyValuesArray:[data objectForKey:@"addresses"]];
//                            NSDictionary *addressDict = [data objectForKey:@"address"];
//                            NSArray *addressList = [data objectForKey:@"addressList"];
//                            address = [[AddressEntity alloc] initWithDictionary:addressDict];
//                            for (NSDictionary *addrDict in addressList) {
//                                AddressEntity *addr = [[AddressEntity alloc] initWithDictionary:addrDict];
//                                [addresses addObject:addr];
//                            }
                        }
                        success(status, code, message, address, addresses);
                    }
                    failure:failure];
}

@end
