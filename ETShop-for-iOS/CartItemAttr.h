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

@interface CartItemAttr : NSObject

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, strong) NSNumber *item_id; //来自CartItem::$id
@property (nonatomic, strong) NSNumber *attr_item_id; //来自ProductAttrItem::$id
@property (nonatomic, strong) NSNumber *attr_item_value_id; //来自ProductAttrItemValue::$id

@end
