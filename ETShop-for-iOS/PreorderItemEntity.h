//
//  PreorderItemEntity.h
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

@interface PreorderItemEntity : BaseEntity

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *imageSmall;
@property (nonatomic, copy) NSString *featuredImage;
@property (nonatomic, copy) NSNumber *price; //当个产品的最终价格，即价格+属性价格
@property (nonatomic, copy) NSNumber *count;
@property (nonatomic, copy) NSNumber *subtotalPrice;
@property (nonatomic, copy) NSNumber *type;//产品类型
@property (nonatomic, copy) NSString *attrPrintNames; //可见的产品属性

@end
