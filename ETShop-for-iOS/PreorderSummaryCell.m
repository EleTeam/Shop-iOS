//
//  PreorderSummaryCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/11/01.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "PreorderSummaryCell.h"

@interface PreorderSummaryCell ()
{
    UIView *_gridLeft;
    UIView *_gridRight;
    
    UILabel *_productPriceTitle;
    UILabel *_productPriceLabel;
    UILabel *_couponPriceTitle;
    UILabel *_couponPriceLabel;
    
    UILabel *_seperator;
    UILabel *_totalPriceTitle;
    UILabel *_totalPriceLabel;
}

@end

@implementation PreorderSummaryCell

+ (CGFloat)height
{
    return 86;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat gridLeftWidth = self.frame.size.width * 0.55;
    CGFloat gridRightWidth = self.frame.size.width - gridLeftWidth;
    CGFloat priceFontSize = 17;
    
    _gridLeft = [UIView new];
    _gridRight = [UIView new];
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
    
    _productPriceTitle = [UILabel new];
    _productPriceTitle.text = @"商品总额";
    [_gridLeft addSubview:_productPriceTitle];
    [_productPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gridLeft).with.offset(8);
        make.top.equalTo(_gridLeft).with.offset(10);
    }];
    
    _productPriceLabel = [UILabel new];
    _productPriceLabel.font = [UIFont systemFontOfSize:priceFontSize];
    [_gridLeft addSubview:_productPriceLabel];
    [_productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_gridLeft).with.offset(-8);
        make.top.equalTo(_productPriceTitle);
    }];
    
    _couponPriceTitle = [UILabel new];
    _couponPriceTitle.text = @"优惠红包";
    [_gridLeft addSubview:_couponPriceTitle];
    [_couponPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_productPriceTitle);
        make.top.equalTo(_productPriceTitle.mas_bottom).with.offset(6);
    }];
    
    _couponPriceLabel = [UILabel new];
    _couponPriceLabel.textColor = kColorMainOrange;
    _couponPriceLabel.font = [UIFont systemFontOfSize:priceFontSize];
    [_gridLeft addSubview:_couponPriceLabel];
    [_couponPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_productPriceLabel);
        make.top.equalTo(_couponPriceTitle);
    }];
    
    _seperator = [UILabel new];
    _seperator.backgroundColor = kColorUnderline;
    [_gridRight addSubview:_seperator];
    [_seperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gridRight);
        make.top.equalTo(_productPriceTitle).with.offset(3);
        make.bottom.equalTo(_couponPriceLabel).with.offset(3);
        make.width.mas_equalTo(1);
    }];
    
    _totalPriceTitle = [UILabel new];
    _totalPriceTitle.text = @"订单总额";
    [_gridRight addSubview:_totalPriceTitle];
    [_totalPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_gridRight);
        make.top.equalTo(_productPriceLabel);
    }];
    
    _totalPriceLabel = [UILabel new];
    _totalPriceLabel.textColor = kColorMainOrange;
    _totalPriceLabel.font = [UIFont systemFontOfSize:priceFontSize];
    [_gridRight addSubview:_totalPriceLabel];
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_gridRight);
        make.top.equalTo(_couponPriceTitle);
    }];
    
    return self;
}

- (void)fillContentWithPreorder:(Preorder *)preorder
{
    if (preorder.id > 0) {
        _productPriceLabel.text = [FormatUtil formatPrice:preorder.origin_total_price];
        _couponPriceLabel.text = [NSString stringWithFormat:@"- %@", [FormatUtil formatPrice:preorder.coupon_item_total_price]];
        _totalPriceLabel.text = [FormatUtil formatPrice:preorder.total_price];
    }
}

@end
