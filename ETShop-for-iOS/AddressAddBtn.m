//
//  AddressAddBtn.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/10/23.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "AddressAddBtn.h"

@interface AddressAddBtn ()

@end

@implementation AddressAddBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self setTitle:@"+ 添加收货地址" forState:UIControlStateNormal];
    [self setTitleColor:kColorWhite forState:UIControlStateNormal];
    [self setBackgroundColor:kColorMainRed];
    [self addTarget:self action:@selector(clickAddAddressBtn) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

- (void)clickAddAddressBtn
{
    [self.delegate doClickAddressAddBtn];
}

@end
