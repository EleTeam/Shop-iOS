//
//  DbUtil.h
//  ETShop-for-iOS
//
//  Created by Tony Wong on 15/9/16.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "ProductAttrItemValue.h"

@interface ProductAttrItem : NSObject

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *print_name;

//商品属性值
@property (nonatomic, copy) NSArray *productAttrItemValues;

@end
