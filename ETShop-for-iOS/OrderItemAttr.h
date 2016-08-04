//
//  OrderItemAttr.h
//  ETShop-for-iOS
//
//  Created by tony on 16/8/3.
//  Copyright © 2016年 黄治华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface OrderItemAttr : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *item_id;
/**
 * 来自 ProductAttrItem 的值
 */
@property (nonatomic, strong) NSString *attr_item_id;
@property (nonatomic, strong) NSString *attr_item_name;
@property (nonatomic, strong) NSString *attr_item_print_name;
@property (nonatomic, strong) NSNumber *attr_item_sort;
/**
 * 来自 ProductAttrItemValue 的值
 */
@property (nonatomic, strong) NSString *attr_item_value_id;
@property (nonatomic, strong) NSString *attr_item_value_name;
@property (nonatomic, strong) NSString *attr_item_value_print_name;
@property (nonatomic, strong) NSNumber *attr_item_value_price;
@property (nonatomic, strong) NSNumber *attr_item_value_sort;
@property (nonatomic, strong) NSNumber *attr_item_value_is_standard;

@end
