//
//  OrderSuccessView.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/9/18.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "OrderSuccessView.h"
#import "ButtonUtil.h"
#import "PriceLabel.h"

@interface OrderSuccessView ()
{
    Order *_order;
    
    UIImageView *_successImage;
    UILabel *_successLabel;
    
    UILabel *_orderNumTitle;
    UILabel *_orderNumLabel;
    
    UILabel *_totalPriceTitle;
    UILabel *_totalPriceLabel;
    
    UIButton *_shoppingBtn;
    UIButton *_viewOrderBtn;
}

@end

@implementation OrderSuccessView

- (instancetype)initWithFrame:(CGRect)frame order:(Order *)order;
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    _order = order;
    
    _successImage = [UIImageView new];
    _successImage.image = [UIImage imageNamed:@"icon_success"];
    [self addSubview:_successImage];
    [_successImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20);
        make.top.equalTo(self).with.offset(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    _successLabel = [UILabel new];
    _successLabel.text = @"恭喜您~下单成功";
    [self addSubview:_successLabel];
    [_successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_successImage.mas_right).with.offset(4);
        make.top.equalTo(_successImage);
    }];
    
    _orderNumTitle = [UILabel new];
    _orderNumTitle.text = @"订单号:";
    [self addSubview:_orderNumTitle];
    [_orderNumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_successImage);
        make.top.equalTo(_successImage.mas_bottom).with.offset(25);
        make.width.mas_equalTo(75);
    }];
    
    _orderNumLabel = [UILabel new];
    _orderNumLabel.text = _order.serial_no;
    [self addSubview:_orderNumLabel];
    [_orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderNumTitle.mas_right);
        make.top.equalTo(_orderNumTitle);
    }];
    
    _totalPriceTitle = [UILabel new];
    _totalPriceTitle.text = @"订单总额:";
    [self addSubview:_totalPriceTitle];
    [_totalPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_successImage);
        make.top.equalTo(_orderNumTitle.mas_bottom).with.offset(8);
        make.width.mas_equalTo(_orderNumTitle);
    }];
    
    _totalPriceLabel = [[PriceLabel alloc] initWithCurPrice:_order.total_price];
    _totalPriceLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:_totalPriceLabel];
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_totalPriceTitle.mas_right);
        make.top.equalTo(_totalPriceTitle);
    }];
    
    _shoppingBtn = [ButtonUtil redButtonWithTitle:@"去购物"];
    [self addSubview:_shoppingBtn];
    [_shoppingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).with.offset(-15);
        make.top.equalTo(_totalPriceTitle.mas_bottom).with.offset(25);
        make.width.mas_equalTo(90);
    }];
    
    _viewOrderBtn = [ButtonUtil redButtonWithTitle:@"查看订单"];
    [self addSubview:_viewOrderBtn];
    [_viewOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).with.offset(15);
        make.top.equalTo(_shoppingBtn);
        make.width.mas_equalTo(_shoppingBtn);
    }];
    
    [_shoppingBtn addTarget:self action:@selector(clickShoppingBtn) forControlEvents:UIControlEventTouchUpInside];
    [_viewOrderBtn addTarget:self action:@selector(clickViewOrderBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)clickShoppingBtn
{
    [self.delegate doGotoShopping];
}

- (void)clickViewOrderBtn
{
    [self.delegate doViewOrder];
}

@end
