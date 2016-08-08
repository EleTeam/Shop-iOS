//
//  Product.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "Product.h"

@implementation Product

// 实现这个方法：告诉MJExtension框架数组里面装的是什么模型
+ (NSDictionary *)objectClassInArray{
    return @{
             @"productAttrs" : [ProductAttr class]
             };
}

- (instancetype)dealFields
{
    NSString *prefix = @"http://";
    int index = 6;
    
    if (self.image && ![prefix isEqualToString:[self.image substringToIndex:index]]) {
        self.image = [NSString stringWithFormat:@"%@%@", kUrlBase, self.image];
    }
    
    if (self.image_small && ![prefix isEqualToString:[self.image_small substringToIndex:index]]) {
        self.image_small = [NSString stringWithFormat:@"%@%@", kUrlBase, self.image_small];
    }
    
    if (self.app_long_image1 && ![prefix isEqualToString:[self.app_long_image1 substringToIndex:index]]) {
        self.app_long_image1 = [NSString stringWithFormat:@"%@%@", kUrlBase, self.app_long_image1];
    }
    
    if (self.app_long_image2 && ![prefix isEqualToString:[self.app_long_image2 substringToIndex:index]]) {
        self.app_long_image2 = [NSString stringWithFormat:@"%@%@", kUrlBase, self.app_long_image2];
    }
    
    if (self.app_long_image3 && ![prefix isEqualToString:[self.app_long_image3 substringToIndex:index]]) {
        self.app_long_image3 = [NSString stringWithFormat:@"%@%@", kUrlBase, self.app_long_image3];
    }
    
    if (self.app_long_image4 && ![prefix isEqualToString:[self.app_long_image4 substringToIndex:index]]) {
        self.app_long_image4 = [NSString stringWithFormat:@"%@%@", kUrlBase, self.app_long_image4];
    }
    
    if (self.app_long_image5 && ![prefix isEqualToString:[self.app_long_image5 substringToIndex:index]]) {
        self.app_long_image5 = [NSString stringWithFormat:@"%@%@", kUrlBase, self.app_long_image5];
    }
    
    return self;
}

//===== 与服务器交互的方法 =====//

//获取商品实体
+ (void)getProduct:(NSNumber *)id
           success:(void(^)(BOOL status, NSNumber *code, NSString *message, Product *product, NSNumber *cart_num, BOOL hasCollectedProduct))success
           failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:kUrlProduct, id];
    [HttpClient requestJson:url
               params:nil
              success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data){
                  Product *product = nil;
                  NSNumber *cart_num = [NSNumber numberWithInt:0];
                  BOOL hasCollectedProduct = NO;
                  if (status) {
                      product = [Product mj_objectWithKeyValues:[data objectForKey:@"product"]];
                      cart_num = [data objectForKey:@"cart_num"];
                  }
                  
                  success(status, code, message, product, cart_num, hasCollectedProduct);
                  
//                  Product *product = nil;
//                  NSNumber *cart_num = [NSNumber numberWithInt:0];
//                  BOOL hasCollectedProduct = NO;
//                  if (result) {
//                      cart_num = [data objectForKey:@"cart_num"];
//                      hasCollectedProduct = [[data objectForKey:@"hasCollectedProduct"] boolValue];
//                      NSDictionary *productDict = [data objectForKey:@"product"];
//                      product = [[Product alloc] initWithDictionary:productDict];
//                      
//                      NSArray *attrItemDicts = [productDict objectForKey:@"attrList"];
//                      if (attrItemDicts && attrItemDicts.count > 0) {
//                          NSMutableArray *attrItems = [[NSMutableArray alloc] init];
//                          for (NSDictionary *attrItemDict in attrItemDicts) {
//                              ProductAttributeItemEntity *attrItem = [[ProductAttributeItemEntity alloc] initWithDictionary:attrItemDict];
//                              
//                              NSArray *itemValueDicts = [attrItemDict objectForKey:@"valueList"];
//                              if (itemValueDicts && itemValueDicts.count > 0) {
//                                  NSMutableArray *itemValues = [[NSMutableArray alloc] init];
//                                  for (NSDictionary *itemValueDict in itemValueDicts) {
//                                      ProductAttributeItemValueEntity *itemValue = [[ProductAttributeItemValueEntity alloc] initWithDictionary:itemValueDict];
//                                      [itemValues addObject:itemValue];
//                                      
//                                  }
//                                  attrItem.itemValues = [itemValues copy];
//                              }
//                              [attrItems addObject:attrItem];
//                          }
//                          //product.attrItems = [attrItems copy];
//                      }
//                  }
//                  success(result, message, product, cart_num, hasCollectedProduct);
              }
              failure:failure];
}

//获取打折的商品列表
+ (void)getFeaturedProducts:(void(^)(BOOL status, NSString *message, NSArray *products))success
                    failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlGetFeaturedProducts;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                        NSArray *products = [Product mj_objectArrayWithKeyValuesArray:[data objectForKey:@"products"]];
                        success(status, message, products);
                    } failure:^(NSError *error) {
                        failure(error);
                    }];
}

//获取精选的商品列表
+ (void)getTopicProducts:(void(^)(BOOL status, NSString *message, NSArray *products))success
                 failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlGetTopicProducts;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL status, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        NSArray *products = [Product mj_objectArrayWithKeyValuesArray:[data objectForKey:@"products"]];
                        success(status, message, products);
                    } failure:^(NSError *error) {
                        failure(error);
                    }];
}

//销量最高的商品列表
+ (void)getTopSaleProducts:(void(^)(BOOL result, NSString *message, NSArray *products))success
                   failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlGetTopSaleProducts;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        NSArray *products = nil;
                        NSMutableArray *productsArr = [NSMutableArray new];
//                        if (result) {
//                            NSArray *dictArr = [data objectForKey:@"productList"];
//                            for (NSDictionary *dict in dictArr) {
//                                Product *product = [[Product alloc] initWithDictionary:dict];
//                                [productsArr addObject:product];
//                            }
//                            products = [productsArr mutableCopy];
//                        }
//                        success(result, message, products);
                    } failure:^(NSError *error) {
                        failure(error);
                    }];
}

@end
