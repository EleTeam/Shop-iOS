//
//  PreorderPayCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/11/01.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "PreorderPayCell.h"

@interface PreorderPayCell ()
{
    NSNumber    *_pay_type;
    
    UILabel     *_vPayTitle;
    
    UIButton    *_vPayWxBtn;
    UIImageView *_vPayWxImage;
    UILabel     *_vPayWxTitle;
    
    UIButton    *_vPayAliBtn;
    UIImageView *_vPayAliImage;
    UILabel     *_vPayAliTitle;
    
    UIButton    *_vPayCashBtn;
    UIImageView *_vPayCashImage;
    UILabel     *_vPayCashTitle;
    
    UILabel     *_vShipTitle;
    
    UIButton    *_vShipPersonBtn;
    UIImageView *_vShipPersonImage;
    UILabel     *_vShipPersonTitle;
}

@end

@implementation PreorderPayCell

+ (CGFloat)height
{
    return 124;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat btnLeftMargin = 16;
    CGFloat imageLeftMargin = 4;
    CGFloat imageWidth = 10;
    
    _vPayTitle = [UILabel new];
    _vPayTitle.text = @"支付方式";
    [self addSubview:_vPayTitle];
    [_vPayTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.top.equalTo(self).with.offset(4);
    }];
    
    _vPayWxBtn = [self createEmptyButton];
    [self addSubview:_vPayWxBtn];
    [_vPayWxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(btnLeftMargin);
        make.top.equalTo(_vPayTitle.mas_bottom).with.offset(4);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(28);
    }];
    
    _vPayWxImage = [self createImageView];
    [_vPayWxBtn addSubview:_vPayWxImage];
    [_vPayWxImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vPayWxBtn).with.offset(imageLeftMargin);
        make.centerY.equalTo(_vPayWxBtn);
        make.width.mas_equalTo(imageWidth);
        make.height.mas_equalTo(imageWidth);
    }];
    _vPayWxImage.hidden = YES;
    
    _vPayWxTitle = [self createTitle:@"微信支付"];
    [_vPayWxBtn addSubview:_vPayWxTitle];
    [_vPayWxTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vPayWxImage.mas_right).with.offset(imageLeftMargin);
        make.centerY.equalTo(_vPayWxBtn);
    }];
    
    _vPayAliBtn = [self createEmptyButton];
    [self addSubview:_vPayAliBtn];
    [_vPayAliBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vPayWxBtn.mas_right).with.offset(btnLeftMargin);
        make.top.equalTo(_vPayWxBtn);
        make.width.mas_equalTo(72);
        make.height.mas_equalTo(_vPayWxBtn);
    }];
    
    _vPayAliImage = [self createImageView];
    [_vPayAliBtn addSubview:_vPayAliImage];
    [_vPayAliImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vPayAliBtn).with.offset(imageLeftMargin);
        make.centerY.equalTo(_vPayAliBtn);
        make.width.mas_equalTo(imageWidth);
        make.height.mas_equalTo(imageWidth);
    }];
    _vPayAliImage.hidden = YES;
    
    _vPayAliTitle = [self createTitle:@"支付宝"];
    [_vPayAliBtn addSubview:_vPayAliTitle];
    [_vPayAliTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vPayAliImage.mas_right).with.offset(imageLeftMargin);
        make.centerY.equalTo(_vPayAliBtn);
    }];
    
    _vPayCashBtn = [self createEmptyButton];
    [self addSubview:_vPayCashBtn];
    [_vPayCashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vPayAliBtn.mas_right).with.offset(btnLeftMargin);
        make.top.equalTo(_vPayAliBtn);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(_vPayAliBtn);
    }];
    
    _vPayCashImage = [self createImageView];
    [_vPayCashBtn addSubview:_vPayCashImage];
    [_vPayCashImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vPayCashBtn).with.offset(imageLeftMargin);
        make.centerY.equalTo(_vPayCashBtn);
        make.width.mas_equalTo(imageWidth);
        make.height.mas_equalTo(imageWidth);
    }];
    _vPayCashImage.hidden = YES;
    
    _vPayCashTitle = [self createTitle:@"现金支付"];
    [_vPayCashBtn addSubview:_vPayCashTitle];
    [_vPayCashTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vPayCashImage.mas_right).with.offset(imageLeftMargin);
        make.centerY.equalTo(_vPayCashBtn);
    }];
    
    //配送方式
    
    _vShipTitle = [UILabel new];
    _vShipTitle.text = @"配送方式";
    [self addSubview:_vShipTitle];
    [_vShipTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vPayTitle);
        make.top.equalTo(_vPayWxBtn.mas_bottom).with.offset(8);
    }];
    
    _vShipPersonBtn = [self createEmptyButton];
    _vShipPersonBtn.layer.borderColor = kColorMainRed.CGColor;
    [self addSubview:_vShipPersonBtn];
    [_vShipPersonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(btnLeftMargin);
        make.top.equalTo(_vShipTitle.mas_bottom).with.offset(4);
        make.width.mas_equalTo(115);
        make.height.mas_equalTo(_vPayWxBtn);
    }];
    
    _vShipPersonImage = [self createImageView];
    [_vShipPersonBtn addSubview:_vShipPersonImage];
    [_vShipPersonImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vShipPersonBtn).with.offset(imageLeftMargin);
        make.centerY.equalTo(_vShipPersonBtn);
        make.width.mas_equalTo(imageWidth);
        make.height.mas_equalTo(imageWidth);
    }];
    //_vShipPersonImage.hidden = YES;
    
    _vShipPersonTitle = [self createTitle:@"专人送货上门"];
    [_vShipPersonBtn addSubview:_vShipPersonTitle];
    [_vShipPersonTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vShipPersonImage.mas_right).with.offset(imageLeftMargin);
        make.centerY.equalTo(_vShipPersonBtn);
    }];
    
    //bind events
    [_vPayWxBtn addTarget:self action:@selector(selectPayType:) forControlEvents:UIControlEventTouchUpInside];
    [_vPayAliBtn addTarget:self action:@selector(selectPayType:) forControlEvents:UIControlEventTouchUpInside];
    [_vPayCashBtn addTarget:self action:@selector(selectPayType:) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (UIButton *)createEmptyButton
{
    UIButton *btn = [UIButton new];
    [btn setTitleColor:kColorMainBlack forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = kColorUnderline.CGColor;
    btn.layer.cornerRadius = 3;
    return btn;
}

- (UIImageView *)createImageView
{
    UIImageView *vImage = [UIImageView new];
    vImage.image = [UIImage imageNamed:@"icon_right"];
    return vImage;
}

- (UILabel *)createTitle:(NSString *)title
{
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = kColorMainBlack;
    label.font = [UIFont systemFontOfSize:14];
    return label;
}

- (void)setPayType:(NSNumber *)pay_type
{
    if (pay_type <= 0) {
        return;
    }
    
    _pay_type = pay_type;
    
    if ([pay_type isEqual:kPayTypeWx]) {
        _vPayWxBtn.layer.borderColor = kColorMainRed.CGColor;
        _vPayWxImage.hidden = NO;
        
        _vPayAliBtn.layer.borderColor = kColorUnderline.CGColor;
        _vPayAliImage.hidden = YES;
        
        _vPayCashBtn.layer.borderColor = kColorUnderline.CGColor;
        _vPayCashImage.hidden = YES;
    }
    else if ([_pay_type isEqual:kPayTypeAli]) {
        _vPayWxBtn.layer.borderColor = kColorUnderline.CGColor;
        _vPayWxImage.hidden = YES;
        
        _vPayAliBtn.layer.borderColor = kColorMainRed.CGColor;
        _vPayAliImage.hidden = NO;
        
        _vPayCashBtn.layer.borderColor = kColorUnderline.CGColor;
        _vPayCashImage.hidden = YES;
    }
    else if ([_pay_type isEqual:kPayTypeCash]) {
        _vPayWxBtn.layer.borderColor = kColorUnderline.CGColor;
        _vPayWxImage.hidden = YES;
        
        _vPayAliBtn.layer.borderColor = kColorUnderline.CGColor;
        _vPayAliImage.hidden = YES;
        
        _vPayCashBtn.layer.borderColor = kColorMainRed.CGColor;
        _vPayCashImage.hidden = NO;
    }
}

- (void)selectPayType:(UIButton *)sender
{
    NSString *pay_type;
    if (sender == _vPayWxBtn) {
        pay_type = kPayTypeWx;
    }
    else if (sender == _vPayAliBtn) {
        pay_type = kPayTypeAli;
    }
    else if (sender == _vPayCashBtn) {
        pay_type = kPayTypeCash;
    }
    [self.delegate doSelectPayType:pay_type];
}

@end
