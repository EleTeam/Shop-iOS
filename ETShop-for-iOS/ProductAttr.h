//
//  DbUtil.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/9/16.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "ProductAttrItem.h"

@interface ProductAttr : NSObject

@property (nonatomic, assign) NSInteger product_id;
@property (nonatomic, assign) NSInteger $item_id;
@property (nonatomic, assign) NSInteger $status;

//商品属性项
@property (nonatomic, strong) ProductAttrItem *productAttrItem;

@end
