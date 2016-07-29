//
//  Category.h
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
#import "Product.h"

@interface ProductCategory : NSObject

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *sort;
@property (nonatomic, strong) NSArray *products; //包含Product

+ (void)getCategoriesWithProducts:(void(^)(BOOL result, NSNumber *code, NSString *message, NSArray *categories))success
                          failure:(void(^)(NSError *error))failure;

@end