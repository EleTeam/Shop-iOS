//
//  PriceLabel.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/22.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>

@interface PriceLabel : UILabel

- (instancetype)initWithFrame:(CGRect)frame price:(NSNumber *)price;

- (instancetype)initWithFrame:(CGRect)frame curPrice:(NSNumber *)curPrice;

- (instancetype)initWithFrame:(CGRect)frame oriPrice:(NSNumber *)oriPrice;

- (instancetype)initWithCurPrice:(NSNumber *)curPrice;

- (instancetype)initWithOriPrice:(NSNumber *)oriPrice;

- (void)setCurPrice:(NSNumber *)curPrice;

- (void)setOriPrice:(NSNumber *)oriPrice;

- (void)setReducePrice:(NSNumber *)reducePrice;

@end
