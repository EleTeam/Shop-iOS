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

@interface ProductAttrItemValue : NSObject

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *print_name;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSNumber *is_standard;

@end
