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

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "Product.h"
#import "CartItemAttr.h"

@interface CartItem : NSObject

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSNumber *count;
@property (nonatomic, copy) NSNumber *is_selected;
@property (nonatomic, copy) NSString *attrPrintNames; //辅助的字段，非实质实体拥有

//自定义的对象必须用strong属性，如果用copy属性将会导致错误（[Product copyWithZone:]: unrecognized selector sent to instance）
@property (nonatomic, strong) Product *product;

//购物车项对应的属性，数组值为CartItemAttr
@property (nonatomic, strong) NSArray *cartItemAttrs;

@end
