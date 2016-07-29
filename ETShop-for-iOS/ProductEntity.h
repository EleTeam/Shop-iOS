//
//  Product.h
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
#import "ProductAttributeItemEntity.h"

@interface ProductEntity : BaseEntity

//以下字段存于本地数据库
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageSmall;
@property (nonatomic, copy) NSNumber *sort; //int
@property (nonatomic, copy) NSNumber *price; //float
@property (nonatomic, copy) NSNumber *featuredPrice; //float
@property (nonatomic, copy) NSNumber *featuredPosition; //int, checkbox in form, 推荐位，以英文逗号分隔（如： ,1,2,）
@property (nonatomic, copy) NSNumber *featuredPositionSort; //int, 推荐位排序
@property (nonatomic, copy) NSNumber *totalCount;

//以下字段未存于本地数据库
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *shortDescription;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *appFeaturedTopic;
@property (nonatomic, copy) NSNumber *appFeaturedTopicSort;
@property (nonatomic, copy) NSString *appLongImage1;
@property (nonatomic, copy) NSString *appLongImage2;
@property (nonatomic, copy) NSString *appLongImage3;
@property (nonatomic, copy) NSString *appLongImage4;
@property (nonatomic, copy) NSString *appLongImage5;

//产品属性，[ProductAttributeItemEntity, ...]
@property (nonatomic, copy) NSArray *attrItems;

//为没有url的字段加上url，便于访问网站
- (instancetype)dealFields;

@end
