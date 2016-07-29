//
//  ProductForm.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/29.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface ProductForm : NSObject

@property (nonatomic, copy) NSNumber *product_id;

@property (nonatomic, copy) NSNumber *count;

//存放当前选择的商品属性，格式为：
// [{itemId:"", valueId:""},...]
//  提交表单时，需要把格式转变为字符串如["3_15","2_10",...]
@property (nonatomic, copy) NSArray *attrIds;

- (instancetype)initWithProduct:(Product *)product;

//根据属性返回字典
- (NSDictionary *)fieldsToDictionary;

//提交表单到服务器
- (void)submit:(void(^)(BOOL status, NSNumber *code, NSString *message, NSDictionary *data))success
       failure:(void(^)(NSError *error))failure;
@end
