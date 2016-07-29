//
//  PreorderModel.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "PreorderModel.h"

@implementation PreorderModel

/**
 * 登陆用户从购物车添加预购订单
 *  只需要访问kUrlPreorderAdd地址即可，不用在本地提交购物车表单
 */
+ (void)add:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, NSString *preorderId))success
    failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlPreorderAdd;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        NSString *preorderId = nil;
                        if (result) {
                            NSDictionary *preorderDict = [data objectForKey:@"preorder"];
                            preorderId = [preorderDict objectForKey:@"id"];
                        }
                        success(result, resultCode, message, preorderId);
                    }
                    failure:failure];
}

//获取预购订单
+ (void)getWithPreorderId:(NSString *)preorderId
                  success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, PreorderEntity *preorder, NSArray *preorderItems, AddressEntity *address))success
                  failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:kUrlPreorderWithId, preorderId];
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        PreorderEntity *preorder = nil;
                        NSMutableArray *preorderItems = [NSMutableArray new];
                        AddressEntity *address = nil;
                        if (result) {
                            NSDictionary *preorderDict = [data objectForKey:@"preorder"];
                            NSArray *prorderItemsDict = [data objectForKey:@"preorderItemList"];
                            NSDictionary *addressDict = [data objectForKey:@"address"];
                            preorder = [[PreorderEntity alloc] initWithDictionary:preorderDict];
                            
                            for (NSDictionary *preorderItemDict in prorderItemsDict) {
                                PreorderItemEntity *preorderItem = [[PreorderItemEntity alloc] initWithDictionary:preorderItemDict];
                                [preorderItems addObject:preorderItem];
                            }
                            
                            address = [[AddressEntity alloc] initWithDictionary:addressDict];
                            
                        }
                        success(result, resultCode, message, preorder, preorderItems, address);
                    }
                    failure:failure];
}

//设置支付方式
+ (void)setPayTypeWithPreorderId:(NSString *)preorderId
                         payType:(NSString *)payType
                         success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, PreorderEntity *preorder))success
                         failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlPreorderSetPayType;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   preorderId,  @"preorderId",
                                   payType,     @"payType", nil];
    [HttpClient requestJson:url
                     params:params
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        PreorderEntity *preorder = nil;
                        if (result) {
                            NSDictionary *preorderDict = [data objectForKey:@"preorder"];
                            preorder = [[PreorderEntity alloc] initWithDictionary:preorderDict];
                        }
                        success(result, resultCode, message, preorder);
                    }
                    failure:failure];
    
}

@end
