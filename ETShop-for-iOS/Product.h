//
//  Product.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "ProductAttr.h"

@interface Product : NSObject

//以下字段存于本地数据库
@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image_small;
@property (nonatomic, copy) NSNumber *sort; //int
@property (nonatomic, copy) NSNumber *price; //float
@property (nonatomic, copy) NSNumber *featured_price; //float
@property (nonatomic, copy) NSNumber *featured_position; //int, checkbox in form, 推荐位，以英文逗号分隔（如： ,1,2,）
@property (nonatomic, copy) NSNumber *featured_positionSort; //int, 推荐位排序
@property (nonatomic, copy) NSNumber *total_count;

//以下字段未存于本地数据库
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *short_description;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *app_featured_topic;
@property (nonatomic, copy) NSNumber *app_featured_topic_sort;
@property (nonatomic, copy) NSString *app_long_image1;
@property (nonatomic, copy) NSString *app_long_image2;
@property (nonatomic, copy) NSString *app_long_image3;
@property (nonatomic, copy) NSString *app_long_image4;
@property (nonatomic, copy) NSString *app_long_image5;

//产品属性，[ProductAttr, ...]
@property (nonatomic, strong) NSArray *productAttrs;


//为没有url的字段加上url，便于访问网站
- (instancetype)dealFields;

//===== 与服务器交互的方法 =====//

//获取商品实体
+ (void)getProduct:(NSNumber *)id
           success:(void(^)(BOOL status, NSNumber *code, NSString *message, Product *product, NSNumber *cart_num, BOOL hasCollectedProduct))success
           failure:(void(^)(NSError *error))failure;

//获取打折的商品列表
+ (void)getFeaturedProducts:(void(^)(BOOL status, NSString *message, NSArray *products))success
                    failure:(void(^)(NSError *error))failure;

//获取精选的商品列表
+ (void)getTopicProducts:(void(^)(BOOL status, NSString *message, NSArray *products))success
                    failure:(void(^)(NSError *error))failure;

//销量最高的商品列表
+ (void)getTopSaleProducts:(void(^)(BOOL status, NSString *message, NSArray *products))success
                    failure:(void(^)(NSError *error))failure;

@end
