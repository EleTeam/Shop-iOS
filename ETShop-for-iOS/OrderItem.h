//
//  OrderItem.h
//  ETShop-for-iOS
//
//  Created by tony on 16/8/3.
//  Copyright © 2016年 黄治华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "OrderItemAttr.h"

@interface OrderItem : NSObject

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *image_small;
@property (nonatomic, copy) NSString *featured_image;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSNumber *count;
@property (nonatomic, copy) NSNumber *subtotal_price;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSArray *orderItemAttr;

@end
