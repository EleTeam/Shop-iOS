//
//  Preorder.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "Preorder.h"

@implementation Preorder

// 实现这个方法：告诉MJExtension框架数组里面装的是什么模型
+ (NSDictionary *)objectClassInArray{
    return @{
             @"preorderItems" : [PreorderItem class]
             };
}

/**
 * 登陆用户从购物车添加预购订单
 *  只需要访问kUrlPreorderAdd地址即可，不用在本地提交购物车表单
 */
+ (void)add:(void(^)(BOOL status, NSNumber *code, NSString *message, NSNumber *id))success
    failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlPreorderAdd;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        NSNumber *id = nil;
                        if (status) {
                            Preorder *preorder = [Preorder mj_objectWithKeyValues:[data objectForKey:@"preorder"]];
                            id = preorder.id;
//                            NSDictionary *preorderDict = [data objectForKey:@"preorder"];
//                            preorderId = [preorderDict objectForKey:@"id"];
                        }
                        success(status, code, message, id);
                    }
                    failure:failure];
}

//获取预购订单
+ (void)getWithId:(NSNumber *)id
                  success:(void(^)(BOOL status, NSNumber *code, NSString *message, Preorder *preorder, Address *address))success
                  failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:kUrlPreorderWithId, id];
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        Preorder *preorder = nil;
                        Address *address = nil;
                        if (status) {
                            preorder = [Preorder mj_objectWithKeyValues:[data objectForKey:@"preorder"]];
//                            NSDictionary *preorderDict = [data objectForKey:@"preorder"];
//                            NSArray *prorderItemsDict = [data objectForKey:@"preorderItemList"];
//                            NSDictionary *addressDict = [data objectForKey:@"address"];
//                            preorder = [[PreorderEntity alloc] initWithDictionary:preorderDict];
//                            
//                            for (NSDictionary *preorderItemDict in prorderItemsDict) {
//                                PreorderItemEntity *preorderItem = [[PreorderItemEntity alloc] initWithDictionary:preorderItemDict];
//                                [preorderItems addObject:preorderItem];
//                            }
//                            
//                            address = [[AddressEntity alloc] initWithDictionary:addressDict];
                            
                        }
                        success(status, code, message, preorder, address);
                    }
                    failure:failure];
}

//设置支付方式
+ (void)setPayTypeWithId:(NSNumber *)id
                         payType:(NSNumber *)pay_type
                         success:(void(^)(BOOL status, NSNumber *code, NSString *message, Preorder *preorder))success
                         failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlPreorderSetPayType;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   id,          @"id",
                                   pay_type,    @"pay_type", nil];
    [HttpClient requestJson:url
                     params:params
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        Preorder *preorder = nil;
                        if (status) {
                            preorder = [Preorder mj_objectWithKeyValues:[data objectForKey:@"preorder"]];
                        }
                        success(status, code, message, preorder);
                    }
                    failure:failure];
    
}

@end
