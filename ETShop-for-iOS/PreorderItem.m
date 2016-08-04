//
//  PreorderItem.m
//  ETShop-for-iOS
//
//  Created by tony on 16/8/3.
//  Copyright © 2016年 黄治华. All rights reserved.
//

#import "PreorderItem.h"

@implementation PreorderItem

// 实现这个方法：告诉MJExtension框架数组里面装的是什么模型
+ (NSDictionary *)objectClassInArray{
    return @{
             @"preorderItemAttrs" : [PreorderItemAttr class]
             };
}

@end
