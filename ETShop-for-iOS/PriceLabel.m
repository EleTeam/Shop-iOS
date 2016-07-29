//
//  PriceLabel.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/22.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "PriceLabel.h"
#import "FormatUtil.h"

@implementation PriceLabel

- (instancetype)initWithFrame:(CGRect)frame price:(NSNumber *)price
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.text = [FormatUtil formatPrice:price];
    self.font = [UIFont systemFontOfSize:18];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame curPrice:(NSNumber *)curPrice
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.text = [FormatUtil formatPrice:curPrice];
    self.font = [UIFont systemFontOfSize:18];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame oriPrice:(NSNumber *)oriPrice
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    //self.text = [FormatUtil formatPrice:oriPrice];
    //self.font = [UIFont systemFontOfSize:14];
    
    //划线居中
    NSDictionary *attrDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont systemFontOfSize:14], NSFontAttributeName,
                                //[UIColor redColor],           NSForegroundColorAttributeName,
                                [NSNumber numberWithInteger:NSUnderlineStyleSingle],   NSStrikethroughStyleAttributeName, nil];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[FormatUtil formatPrice:oriPrice] attributes:attrDict];
    self.attributedText = attrStr;
    
    return self;
}

- (instancetype)initWithCurPrice:curPrice
{
    self = [super init];
    if (!self) return nil;
    
    self.text = [FormatUtil formatPrice:curPrice];
    self.font = [UIFont systemFontOfSize:18];
    self.textColor = kColorMainOrange;
    
    return self;
}

- (instancetype)initWithOriPrice:oriPrice
{
    self = [super init];
    if (!self) return nil;
    
    //划线居中
    NSDictionary *attrDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [UIFont systemFontOfSize:14], NSFontAttributeName,
                              kColorMainGrey,               NSForegroundColorAttributeName,
                              [NSNumber numberWithInteger:NSUnderlineStyleSingle],   NSStrikethroughStyleAttributeName, nil];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[FormatUtil formatPrice:oriPrice] attributes:attrDict];
    self.attributedText = attrStr;
    
    return self;
}

- (void)setCurPrice:(NSNumber *)curPrice
{
    self.text = [FormatUtil formatPrice:curPrice];
    self.font = [UIFont systemFontOfSize:18];
    self.textColor = kColorMainOrange;
}

- (void)setOriPrice:(NSNumber *)oriPrice
{
    //中划线
    NSDictionary *attrDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [UIFont systemFontOfSize:14], NSFontAttributeName,
                              kColorMainGrey,               NSForegroundColorAttributeName,
                              [NSNumber numberWithInteger:NSUnderlineStyleSingle],   NSStrikethroughStyleAttributeName, nil];

    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:[FormatUtil formatPrice:oriPrice] attributes:attrDict];
    self.attributedText = attrStr;
}

- (void)setReducePrice:(NSNumber *)reducePrice
{
    self.text = [NSString stringWithFormat:@"立减%@元", [FormatUtil formatPrice:reducePrice]];
    self.font = [UIFont systemFontOfSize:14];
    self.textColor = kColorMainOrange;
    self.layer.borderColor = kColorMainOrange.CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 3;
}

@end
