//
//  DbUtil.h
//  ETShop-for-iOS
//
//  Created by Tony Wong on 15/9/16.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "CartItem.h"

@implementation CartItem

// 实现这个方法：告诉MJExtension框架数组里面装的是什么模型
+ (NSDictionary *)objectClassInArray{
    return @{
             @"cartItemAttrs" : [CartItemAttr class]
             };
}

@end
