//
//  OrderStatus.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/19.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseEntity.h"

@interface OrderStatus : BaseEntity

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *roughPayType; //关联于 Order.roughPayType
@property (nonatomic, copy) NSString *statusUnion; //格式：roughPayType-status 如 1-100
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *pendingLabel;

@end
