//
//  PreorderItem.h
//  ETShop-for-iOS
//
//  Created by tony on 16/8/3.
//  Copyright © 2016年 黄治华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "PreorderItemAttr.h"

@interface PreorderItem : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *image_small;
@property (nonatomic, strong) NSString *featured_image;
@property (nonatomic, strong) NSNumber *price; //当个产品的最终价格，即价格+属性价格
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *subtotal_price;
@property (nonatomic, strong) NSNumber *type;//产品类型
@property (nonatomic, strong) NSString *attr_print_names; //可见的产品属性

@property (nonatomic, strong) NSArray *preorderItemAttrs;

@end
