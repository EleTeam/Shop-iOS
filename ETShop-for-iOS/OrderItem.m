//
//  OrderItem.m
//  ETShop-for-iOS
//
//  Created by tony on 16/8/3.
//  Copyright © 2016年 黄治华. All rights reserved.
//

#import "OrderItem.h"
#import "OrderItemAttr.h"

@implementation OrderItem

// 实现这个方法：告诉MJExtension框架数组里面装的是什么模型
+ (NSDictionary *)objectClassInArray{
    return @{
             @"orderItemAttr" : [OrderItemAttr class]
             };
}

@end
