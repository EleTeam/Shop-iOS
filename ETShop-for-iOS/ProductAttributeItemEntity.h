//
//  ProductAttributeItemEntity.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/26.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseEntity.h"
#import "ProductAttributeItemValueEntity.h"

@interface ProductAttributeItemEntity : BaseEntity

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *printName;

//商品属性值，[ProductAttributeItemValueEntity, ...]
@property (nonatomic, copy) NSArray  *itemValues;

@end
