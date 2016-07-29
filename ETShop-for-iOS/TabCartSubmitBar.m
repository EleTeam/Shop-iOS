//
//  TabCartSubmitBar.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "TabCartSubmitBar.h"

@interface TabCartSubmitBar ()
{
    UILabel *_vLeft;
    UIButton *_vSubmitCartBtn;
}

@end


@implementation TabCartSubmitBar

+ (CGFloat)height
{
    return 54;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    // 划分为2个等宽的grid
    CGFloat gridWidth = self.frame.size.width / 2;
    UIView *grid1 = [UIView new];
    UIView *grid2 = [UIView new];
    grid1.backgroundColor = kColorMainGrey;
    grid2.backgroundColor = kColorMainRed;
    [self addSubview:grid1];
    [self addSubview:grid2];
    [grid1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(gridWidth);
        make.height.equalTo(self);
    }];
    [grid2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grid1.mas_right);
        make.top.equalTo(self);
        make.width.mas_equalTo(gridWidth);
        make.height.equalTo(self);
    }];
    
    //_vLeft
    _vLeft = [UILabel new];
    _vLeft.textAlignment = NSTextAlignmentCenter;
    _vLeft.textColor = kColorWhite;
    _vLeft.text = @"欢迎购买";
    [grid1 addSubview:_vLeft];
    [_vLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid1);
        make.centerY.equalTo(grid1);
    }];
    
    //_vSubmitCartBtn
    _vSubmitCartBtn = [UIButton new];
    _vSubmitCartBtn.backgroundColor = kColorMainRed;
    [_vSubmitCartBtn setTitle:@"去结算(0)" forState:UIControlStateNormal];
    [_vSubmitCartBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    [grid2 addSubview:_vSubmitCartBtn];
    [_vSubmitCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid2);
        make.centerY.equalTo(grid2);
        make.width.equalTo(grid2);
        make.height.equalTo(grid2);
    }];
    
    //bind events
    [_vSubmitCartBtn addTarget:self action:@selector(clickSubmitCartBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)setCartNum:(NSNumber *)cart_num
{
    NSString *str = [NSString stringWithFormat:@"去结算(%@)", cart_num];
    [_vSubmitCartBtn setTitle:str forState:UIControlStateNormal];
}

- (void)clickSubmitCartBtn
{
    [self.delegate doClickSubmitCartBtn];
}

@end
