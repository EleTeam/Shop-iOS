//
//  OrderItemEntity.h
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
#import "OrderItemAttributeEntity.h"

@interface OrderItemEntity : BaseEntity

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *imageSmall;
@property (nonatomic, copy) NSString *featuredImage;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSNumber *count;
@property (nonatomic, copy) NSNumber *subtotalPrice;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) OrderItemAttributeEntity *attributeList;

@end
