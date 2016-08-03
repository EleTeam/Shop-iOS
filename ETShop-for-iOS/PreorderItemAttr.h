//
//  PreorderItemAttr.h
//  ETShop-for-iOS
//
//  Created by tony on 16/8/3.
//  Copyright © 2016年 黄治华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface PreorderItemAttr : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *item_id;
/**
 * 来自 ProductAttributeItemEntity的值
 */
@property (nonatomic, strong) NSString *attributeItemId;
@property (nonatomic, strong) NSString *attributeItemName;
@property (nonatomic, strong) NSString *attributeItemPrintName;
@property (nonatomic, strong) NSNumber *attributeItemSort;

/**
 * 来自 ProductAttributeItemValueEntity的值
 */
@property (nonatomic, strong) NSString *attributeItemValueId;
@property (nonatomic, strong) NSString *attributeItemValueName;
@property (nonatomic, strong) NSString *attributeItemValuePrintName;
@property (nonatomic, strong) NSNumber *attributeItemValuePrice;
@property (nonatomic, strong) NSNumber *attributeItemValueSort;
@property (nonatomic, strong) NSNumber *attributeItemValueIsStandard;

@end
