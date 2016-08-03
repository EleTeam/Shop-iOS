//
//  PreorderSubmitView.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/11/01.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "PreorderSubmitView.h"

@interface PreorderSubmitView ()
{
    UIView *_gridLeft;
    UIView *_gridRight;
    
    UILabel *_totalPriceTitle;
    UILabel *_totalPriceLabel;
    
    UIButton *_submitBtn;
}

@end

@implementation PreorderSubmitView

+ (CGFloat)height
{
    return 44;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    CGFloat gridLeftWidth = self.frame.size.width * 0.5;
    CGFloat gridRightWidth = self.frame.size.width - gridLeftWidth;
    
    _gridLeft = [UIView new];
    _gridRight = [UIView new];
    _gridLeft.backgroundColor = kColorMainBlack;
    _gridRight.backgroundColor = kColorMainRed;
    [self addSubview:_gridLeft];
    [self addSubview:_gridRight];
    [_gridLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(gridLeftWidth);
    }];
    [_gridRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gridLeft.mas_right);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(gridRightWidth);
    }];
    
    _totalPriceTitle = [UILabel new];
    _totalPriceTitle.text = @"订单总额:";
    _totalPriceTitle.textColor = kColorWhite;
    [_gridLeft addSubview:_totalPriceTitle];
    [_totalPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gridLeft).with.offset(12);
        make.centerY.equalTo(_gridLeft);
    }];
    
    _totalPriceLabel = [UILabel new];
    _totalPriceLabel.font = [UIFont systemFontOfSize:17];
    _totalPriceLabel.textColor = kColorWhite;
    [_gridLeft addSubview:_totalPriceLabel];
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_totalPriceTitle.mas_right).with.offset(4);
        make.top.equalTo(_totalPriceTitle);
    }];
    
    _submitBtn = [UIButton new];
    [_submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_gridRight addSubview:_submitBtn];
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_gridRight);
        make.centerY.equalTo(_gridRight);
    }];
    
    [_submitBtn addTarget:self action:@selector(clickSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)fillContentWithPreorder:(Preorder *)preorder
{
    if (preorder.id > 0) {
        _totalPriceLabel.text = [FormatUtil formatPrice:preorder.total_price];
    }
}

- (void)clickSubmitBtn
{
    [self.delegate doClickSubmitBtn];
}

@end
