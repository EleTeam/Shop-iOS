//
//  TabCartItemCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "TabCartItemCell.h"

@interface TabCartItemCell ()
{
    UIButton *_vSelectBtn;
    UIImageView *_vImage;
    UILabel *_vTitle;
    UILabel *_vAttr;
    PriceLabel *_vCurPrice;
    PriceLabel *_vOriPrice;
    UIButton *_vMinusBtn;
    UIButton *_vPlusBtn;
    UILabel *_vCount;
    UIButton *_vDeleteBtn;
}

@end

@implementation TabCartItemCell

+ (CGFloat)height
{
    return 100;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        
        CGFloat margin = 8;
        
        //vSelectImageWrap
        UIView *vSelectImageWrap = [UIView new];
        CGFloat vSelectImageWrapWidth = 35;
        CGFloat vSelectImageWrapHeight = 60;
        [self addSubview:vSelectImageWrap];
        
        [vSelectImageWrap mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(vSelectImageWrapWidth);
            make.height.mas_equalTo(vSelectImageWrapHeight);
        }];
        
        //_vSelectBtn
        CGFloat vSelectImageWidth = 15;
        CGFloat vSelectImageHeight = 15;
        _vSelectBtn = [UIButton new];
        [vSelectImageWrap addSubview:_vSelectBtn];
        
        [_vSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vSelectImageWrap.mas_left).with.offset(4);
            make.centerY.equalTo(vSelectImageWrap.mas_centerY);
            make.width.mas_equalTo(vSelectImageWidth);
            make.height.mas_equalTo(vSelectImageHeight);
        }];
        
        //_vImage
        CGFloat vImageWidth = 50;
        CGFloat vImageHeight = 50;
        _vImage = [UIImageView new];
        _vImage.layer.cornerRadius = 5;
        _vImage.image = [UIImage imageNamed:@"image_holder"];
        [self addSubview:_vImage];
        
        [_vImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vSelectImageWrap.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(vImageWidth);
            make.height.mas_equalTo(vImageHeight);
        }];
        
        //_vTitle
        _vTitle = [UILabel new];
        _vTitle.textColor = kColorMainBlack;
        [self addSubview:_vTitle];
        
        [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_vImage.mas_right).with.offset(margin);
            make.top.equalTo(self.mas_top).with.offset(margin);
        }];
        
        //_vAttr
        _vAttr = [UILabel new];
        _vAttr.textColor = kColorMainGrey;
        _vAttr.font = [UIFont systemFontOfSize:13];
        [self addSubview:_vAttr];
        
        [_vAttr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_vTitle.mas_left);
            make.top.equalTo(_vTitle.mas_bottom);
        }];
        
        //_vCurPrice
        _vCurPrice = [PriceLabel new];
        [self addSubview:_vCurPrice];
        
        [_vCurPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_vTitle);
            make.top.equalTo(_vAttr.mas_bottom).with.offset(1);
            make.width.mas_equalTo(80);
        }];
        
        //_vOriPrice
        _vOriPrice = [PriceLabel new];
        [self addSubview:_vOriPrice];
        
        [_vOriPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_vCurPrice.mas_right);
            make.bottom.equalTo(_vCurPrice.mas_bottom);
        }];
        
        //vOperatorWrap
        CGFloat operatorWrapWidth = 90;
        CGFloat operatorGridWidth = operatorWrapWidth / 3;
        UIView *vOperatorWrap = [UIView new];
        vOperatorWrap.layer.borderWidth = 1;
        vOperatorWrap.layer.borderColor = kColorMainBorderGrey.CGColor;
        vOperatorWrap.layer.cornerRadius = 3;
        [self addSubview:vOperatorWrap];
        [vOperatorWrap mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_vTitle.mas_left);
            make.top.equalTo(_vCurPrice.mas_bottom).with.offset(2);
            make.width.mas_equalTo(operatorWrapWidth);
            make.height.mas_equalTo(26);
        }];
        
        //vOperatorGrid
        UIView *vOperatorGrid1 = [UIView new];
        UIView *vOperatorGrid2 = [UIView new];
        UIView *vOperatorGrid3 = [UIView new];
        //vOperatorGrid1.backgroundColor = kColorRed;
        //vOperatorGrid2.backgroundColor = kColorBackgound;
        //vOperatorGrid3.backgroundColor = kColorBlack;
        [vOperatorWrap addSubview:vOperatorGrid1];
        [vOperatorWrap addSubview:vOperatorGrid2];
        [vOperatorWrap addSubview:vOperatorGrid3];
        [vOperatorGrid1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(operatorGridWidth);
            make.height.equalTo(vOperatorWrap.mas_height);
        }];
        [vOperatorGrid2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vOperatorGrid1.mas_right);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(operatorGridWidth);
            make.height.equalTo(vOperatorWrap.mas_height);
        }];
        [vOperatorGrid3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vOperatorGrid2.mas_right);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(operatorGridWidth);
            make.height.equalTo(vOperatorWrap.mas_height);
        }];
        
        //_vMinusBtn
        _vMinusBtn = [UIButton new];
        [_vMinusBtn setImage:[UIImage imageNamed:@"operator_minus_do"] forState:UIControlStateNormal];
        [vOperatorGrid1 addSubview:_vMinusBtn];
        [_vMinusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(vOperatorGrid1);
            make.centerY.equalTo(vOperatorGrid1);
            make.width.mas_equalTo(15);
            make.height.mas_equalTo(15);
        }];

        //_vCount
        _vCount = [UILabel new];
        _vCount.textAlignment = NSTextAlignmentCenter;
        _vCount.layer.borderWidth = 1;
        _vCount.layer.borderColor = kColorMainBorderGrey.CGColor;
        [vOperatorGrid2 addSubview:_vCount];
        [_vCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(vOperatorGrid2);
            make.centerY.equalTo(vOperatorGrid2);
            make.width.mas_equalTo(operatorGridWidth);
            make.height.equalTo(vOperatorWrap.mas_height);
        }];

        //_vPlusBtn
        _vPlusBtn = [UIButton new];
        [_vPlusBtn setImage:[UIImage imageNamed:@"operator_plus_do"] forState:UIControlStateNormal];
        [vOperatorGrid3 addSubview:_vPlusBtn];
        [_vPlusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(vOperatorGrid3);
            make.centerY.equalTo(vOperatorGrid3);
            make.width.mas_equalTo(_vMinusBtn);
            make.height.mas_equalTo(_vMinusBtn);
        }];
        
        //_vDeleteImage
        _vDeleteBtn = [UIButton new];
        [_vDeleteBtn setImage:[UIImage imageNamed:@"operator_trash"] forState:UIControlStateNormal];
        [self addSubview:_vDeleteBtn];
        [_vDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-5);
            make.top.equalTo(vOperatorWrap.mas_top).offset(2);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(35);
        }];
        
        // bind events
        [_vMinusBtn addTarget:self action:@selector(clickMinusBtn) forControlEvents:UIControlEventTouchUpInside];
        [_vPlusBtn addTarget:self action:@selector(clickPlusBtn) forControlEvents:UIControlEventTouchUpInside];
        [_vDeleteBtn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
        [_vSelectBtn addTarget:self action:@selector(clickSelectBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

//Cell里面的每个元素都要重置，否则会混乱
- (void)fillContentWithCartItem:(CartItem *)cartItem couponUser:(NSArray *)couponUsers total_price:(NSNumber *)total_price
{
    self.cartItemId = cartItem.id;
    [self setIsSelectedBy:cartItem.is_selected];
    
    [_vImage sd_setImageWithURL:[NSURL URLWithString:cartItem.product.image_small]];
    _vTitle.text = cartItem.product.name;
    
    if (cartItem.attrPrintNames.length) {
        _vAttr.text = [NSString stringWithFormat:@"(%@)", cartItem.attrPrintNames];
    } else {
        _vAttr.text = nil;
    }
    
    float reducePrice = [cartItem.product.price floatValue] - [cartItem.product.featured_price floatValue];
    if ([cartItem.product.featured_price floatValue] > 0 && reducePrice > 0) {
        [_vCurPrice setCurPrice:cartItem.product.featured_price];
        [_vOriPrice setOriPrice:cartItem.product.price];
        _vCurPrice.font = [UIFont systemFontOfSize:17];
        _vOriPrice.font = [UIFont systemFontOfSize:13];
    } else {
        [_vCurPrice setCurPrice:cartItem.product.price];
        _vCurPrice.font = [UIFont systemFontOfSize:17];
        _vOriPrice.text = nil;
        _vOriPrice.attributedText = nil;
    }
    
    _vCount.text = [cartItem.count stringValue];
}

//设置购物车项的数量
- (void) setCount:(NSNumber *)count
{
    _vCount.text = [count stringValue];
}

//获得购物车项的数量
- (NSNumber *)getCount
{
    return [NSNumber numberWithInt:[_vCount.text intValue]];
}

//设置选择项的图片
- (void)setSelected
{
    [_vSelectBtn setImage:[UIImage imageNamed:@"operator_selected_yes"] forState:UIControlStateNormal];
}

//设置未选择项的图片
- (void)setUnselected
{
    [_vSelectBtn setImage:[UIImage imageNamed:@"operator_selected_no"] forState:UIControlStateNormal];
}

//设置是否选择项的图片
- (void)setIsSelectedBy:(NSNumber *)is_selected
{
    _is_selected = is_selected;
    BOOL isSelectedBool = [is_selected boolValue];
    if (isSelectedBool) {
        [self setSelected];
    } else {
        [self setUnselected];
    }
}

#pragma mark - bind events

- (void)clickMinusBtn
{
    [self.delegate doClickMinus:self];
}

- (void)clickPlusBtn
{
    [self.delegate doClickPlus:self];
}

- (void)clickDeleteBtn
{
    [self.delegate doClickDelete:self];
}

- (void)clickSelectBtn
{
    NSNumber *is_selected;
    if ([self.is_selected boolValue]) {
        is_selected = [NSNumber numberWithInt:0];
    } else {
        is_selected = [NSNumber numberWithInt:1];
    }
    [self.delegate doClickSelect:self is_selected:is_selected];
}

@end
