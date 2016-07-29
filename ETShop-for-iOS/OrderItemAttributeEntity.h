//
//  OrderItemAttributeEntity.h
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

@interface OrderItemAttributeEntity : BaseEntity

@property (nonatomic, copy) NSString *attributeIdstring;

/**
 * 来自 ShopProductAttributeItem
 */
@property (nonatomic, copy) NSString *attributeItemId;
@property (nonatomic, copy) NSString *attributeItemName;
@property (nonatomic, copy) NSString *attributeItemPrintName;
@property (nonatomic, copy) NSNumber *attributeItemSort;

/**
 * 来自 ShopProductAttributeItemValue
 */
@property (nonatomic, copy) NSString *attributeItemValueId;
@property (nonatomic, copy) NSString *attributeItemValueName;
@property (nonatomic, copy) NSString *attributeItemValuePrintName;
@property (nonatomic, copy) NSNumber *attributeItemValuePrice;
@property (nonatomic, copy) NSNumber *attributeItemValueSort;
@property (nonatomic, copy) NSString *attributeItemValueIsStandard;

@end
