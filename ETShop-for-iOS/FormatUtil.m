//
//  FormatUtil.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/22.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "FormatUtil.h"

@implementation FormatUtil

+ (NSString *)formatPrice:(NSNumber *)price {
    float floatPrice = [price floatValue];
    NSString *priceStr = [self formatFloatPrice:floatPrice];
    return priceStr;
}

+ (NSString *)formatFloatPrice:(float)price {
    NSString *priceStr = [NSString stringWithFormat:@"￥%.2f", price];
    
    /*
     NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
     formatter.numberStyle = NSNumberFormatterD
     NSString *priceStr = [formatter stringFromNumber:[NSNumber numberWithFloat:price]];
     */
    
    return priceStr;
}

@end
