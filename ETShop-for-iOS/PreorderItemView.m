//
//  PreorderItemView.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/11/01.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "PreorderItemView.h"

@interface PreorderItemView ()
{
    UIImageView *_vImage;
    UILabel     *_vName;
    UILabel     *_vAttrs;
    UILabel     *_vPrice;
    UILabel     *_vCount;
}

@end

@implementation PreorderItemView

+ (CGFloat)height
{
    return 64;
}

- (void)setupWithPreorderItem:(PreorderItem *)preorderItem
{
    _vImage = [UIImageView new];
    [_vImage sd_setImageWithURL:[NSURL URLWithString:preorderItem.image_small] placeholderImage:[UIImage imageNamed:@"image_holder"]];
    [self addSubview:_vImage];
    [_vImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(16);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    _vName = [UILabel new];
    _vName.text = preorderItem.name;
    [self addSubview:_vName];
    [_vName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vImage.mas_right).with.offset(8);
        make.top.equalTo(self).with.offset(6);
    }];
    
    _vAttrs = [UILabel new];
    if (preorderItem.attr_print_names.length > 0) {
        _vAttrs.text = [NSString stringWithFormat:@"(%@)", preorderItem.attr_print_names];
    }
    _vAttrs.font = [UIFont systemFontOfSize:14];
    _vAttrs.textColor = [UIColor hexColor:@"a1a1a1"];
    [self addSubview:_vAttrs];
    [_vAttrs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vName);
        make.top.equalTo(_vName.mas_bottom);
    }];
    
    _vPrice = [[PriceLabel alloc] initWithCurPrice:preorderItem.price];
    _vPrice.font = [UIFont systemFontOfSize:15];
    [self addSubview:_vPrice];
    [_vPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vName);
        make.top.equalTo(_vAttrs.mas_bottom);
    }];
    
    _vCount = [UILabel new];
    _vCount.text = [NSString stringWithFormat:@"x %@", preorderItem.count];
    _vCount.textColor = [UIColor hexColor:@"a1a1a1"];
    _vCount.font = [UIFont systemFontOfSize:13];
    [self addSubview:_vCount];
    [_vCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vPrice.mas_right).with.offset(4);
        make.bottom.equalTo(_vPrice);
    }];
}

@end
