//
//  Product.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/19.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "ProductEntity.h"

@implementation ProductEntity

- (instancetype)dealFields
{
    NSString *prefix = @"http://";
    int index = 6;
    
    if (self.image && ![prefix isEqualToString:[self.image substringToIndex:index]]) {
        self.image = [NSString stringWithFormat:@"%@%@", kUrlBase, self.image];
    }
    
    if (self.imageSmall && ![prefix isEqualToString:[self.imageSmall substringToIndex:index]]) {
        self.imageSmall = [NSString stringWithFormat:@"%@%@", kUrlBase, self.imageSmall];
    }
    
    if (self.appLongImage1 && ![prefix isEqualToString:[self.appLongImage1 substringToIndex:index]]) {
        self.appLongImage1 = [NSString stringWithFormat:@"%@%@", kUrlBase, self.appLongImage1];
    }
    
    if (self.appLongImage2 && ![prefix isEqualToString:[self.appLongImage2 substringToIndex:index]]) {
        self.appLongImage2 = [NSString stringWithFormat:@"%@%@", kUrlBase, self.appLongImage2];
    }
    
    if (self.appLongImage3 && ![prefix isEqualToString:[self.appLongImage3 substringToIndex:index]]) {
        self.appLongImage3 = [NSString stringWithFormat:@"%@%@", kUrlBase, self.appLongImage3];
    }
    
    if (self.appLongImage4 && ![prefix isEqualToString:[self.appLongImage4 substringToIndex:index]]) {
        self.appLongImage4 = [NSString stringWithFormat:@"%@%@", kUrlBase, self.appLongImage4];
    }
    
    if (self.appLongImage5 && ![prefix isEqualToString:[self.appLongImage5 substringToIndex:index]]) {
        self.appLongImage5 = [NSString stringWithFormat:@"%@%@", kUrlBase, self.appLongImage5];
    }
    
    return self;
}

@end
