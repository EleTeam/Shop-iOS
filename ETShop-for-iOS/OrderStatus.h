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

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface OrderStatus : NSObject

@property (nonatomic, copy) NSNumber *status;
@property (nonatomic, copy) NSNumber *rough_pay_type; //关联于 rough_pay_type
@property (nonatomic, copy) NSString *status_union; //格式：rough_pay_type-status 如 1-100
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *pending_label;

@end
