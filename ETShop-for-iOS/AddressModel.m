//
//  AddressModel.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "AddressModel.h"

@implementation AddressModel

/**
 * 添加收货地址
 */
+ (void)addWithAreaId:(NSString *)areaId
            telephone:(NSString *)telephone
               detail:(NSString *)detail
             fullname:(NSString *)fullname
              success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, AddressEntity *address, NSArray *addresses))success
              failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlAddressAdd;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   areaId,      @"areaId",
                                   telephone,   @"telephone",
                                   detail,      @"detail",
                                   fullname,    @"fullname", nil];
    [HttpClient requestJson:url
                     params:params
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        AddressEntity *address = nil;
                        NSMutableArray *addresses = [NSMutableArray new];
                        if (result) {
                            NSDictionary *addressDict = [data objectForKey:@"address"];
                            NSArray *addressList = [data objectForKey:@"addressList"];
                            address = [[AddressEntity alloc] initWithDictionary:addressDict];
                            for (NSDictionary *addrDict in addressList) {
                                AddressEntity *addr = [[AddressEntity alloc] initWithDictionary:addrDict];
                                [addresses addObject:addr];
                            }
                        }
                        success(result, resultCode, message, address, addresses);
                    }
                    failure:failure];
}

//获得地址列表
+ (void)getAddresses:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, NSArray *addresses))success
             failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlAddressGetList;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        NSMutableArray *addresses = [NSMutableArray new];
                        if (result) {
                            NSArray *addressList = [data objectForKey:@"addressList"];
                            for (NSDictionary *addressDict in addressList) {
                                NSDictionary *areaDict = [addressDict objectForKey:@"area"];
                                AreaEntity *area = [[AreaEntity alloc] initWithDictionary:areaDict];
                                AddressEntity *address = [[AddressEntity alloc] initWithDictionary:addressDict];
                                address.area = area;
                                [addresses addObject:address];
                            }
                        }
                        success(result, resultCode, message, addresses);
                    }
                    failure:failure];
}

//设置默认地址
+ (void)setDefaultWithId:(NSString *)addressId
                 success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, AddressEntity *address, NSArray *addresses))success
                 failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:kUrlAddressSetDefaultWithId, addressId];
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        AddressEntity *address = nil;
                        NSMutableArray *addresses = [NSMutableArray new];
                        if (result) {
                            NSDictionary *addressDict = [data objectForKey:@"address"];
                            NSArray *addressList = [data objectForKey:@"addressList"];
                            address = [[AddressEntity alloc] initWithDictionary:addressDict];
                            for (NSDictionary *addrDict in addressList) {
                                AddressEntity *addr = [[AddressEntity alloc] initWithDictionary:addrDict];
                                [addresses addObject:addr];
                            }
                        }
                        success(result, resultCode, message, address, addresses);
                    }
                    failure:failure];
}

@end
