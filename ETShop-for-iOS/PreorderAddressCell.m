//
//  PreorderAddressCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/11/01.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "PreorderAddressCell.h"

@interface PreorderAddressCell ()
{
    UIButton *_vGridBtn;
    
    UIImageView *_vNoAddressIcon;
    UILabel *_vNoAddressLabel;
    
    UIImageView *_vReciverIcon;
    UILabel *_vReciverLabel;
    
    UIImageView *_vMobileIcon;
    UILabel *_vMobileLabel;
    
    UILabel *_vAddressLabel;
}

@end

@implementation PreorderAddressCell

+ (CGFloat)height
{
    return 68;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    CGFloat leftMargin = 8;
    
    _vGridBtn = [UIButton new];
    [self addSubview:_vGridBtn];
    [_vGridBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.height.mas_equalTo([PreorderAddressCell height]);
    }];
    
    _vNoAddressIcon = [UIImageView new];
    _vNoAddressIcon.image = [UIImage imageNamed:@"icon_person_address"];
    [_vGridBtn addSubview:_vNoAddressIcon];
    [_vNoAddressIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vGridBtn).with.offset(20);
        make.centerY.equalTo(_vGridBtn);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    _vNoAddressLabel = [UILabel new];
    _vNoAddressLabel.text = @"请选择您的收货地址";
    [_vGridBtn addSubview:_vNoAddressLabel];
    [_vNoAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vNoAddressIcon.mas_right).with.offset(10);
        make.centerY.equalTo(_vGridBtn);
    }];
    
    _vReciverIcon = [UIImageView new];
    _vReciverIcon.image = [UIImage imageNamed:@"icon_person_address"];
    [_vGridBtn addSubview:_vReciverIcon];
    [_vReciverIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftMargin);
        make.top.mas_equalTo(_vGridBtn).with.offset(6);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    _vReciverLabel = [UILabel new];
    [_vGridBtn addSubview:_vReciverLabel];
    [_vReciverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vReciverIcon.mas_right).with.offset(6);
        make.top.mas_equalTo(_vGridBtn).with.offset(4);
    }];
    
    _vMobileIcon = [UIImageView new];
    _vMobileIcon.image = [UIImage imageNamed:@"icon_mobile"];
    [_vGridBtn addSubview:_vMobileIcon];
    [_vMobileIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vReciverLabel.mas_right).with.offset(15);
        make.top.mas_equalTo(_vReciverIcon);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(13);
    }];
    
    _vMobileLabel = [UILabel new];
    [_vGridBtn addSubview:_vMobileLabel];
    [_vMobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vMobileIcon.mas_right).with.offset(6);
        make.top.equalTo(_vReciverLabel);
    }];
    
    _vAddressLabel = [UILabel new];
    _vAddressLabel.numberOfLines = 2;
    _vAddressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _vAddressLabel.font = [UIFont systemFontOfSize:15];
    [_vGridBtn addSubview:_vAddressLabel];
    [_vAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vReciverIcon);
        make.right.equalTo(_vGridBtn.mas_right).with.offset(-30);
        make.top.equalTo(_vReciverIcon.mas_bottom).with.offset(6);
    }];
    
    [self hideAllItems];
    
    [_vGridBtn addTarget:self action:@selector(clickGridBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)hideAllItems
{
    _vNoAddressIcon.hidden = YES;
    _vNoAddressLabel.hidden = YES;
    
    _vReciverIcon.hidden = YES;
    _vReciverLabel.hidden = YES;
    
    _vMobileIcon.hidden = YES;
    _vMobileLabel.hidden = YES;
    
    _vAddressLabel.hidden = YES;
}

- (void)showNoAddressItems
{
    _vNoAddressIcon.hidden = NO;
    _vNoAddressLabel.hidden = NO;
    
    _vReciverIcon.hidden = YES;
    _vReciverLabel.hidden = YES;
    
    _vMobileIcon.hidden = YES;
    _vMobileLabel.hidden = YES;
    
    _vAddressLabel.hidden = YES;
}

- (void)showAddressItems
{
    _vNoAddressIcon.hidden = YES;
    _vNoAddressLabel.hidden = YES;
    
    _vReciverIcon.hidden = NO;
    _vReciverLabel.hidden = NO;
    
    _vMobileIcon.hidden = NO;
    _vMobileLabel.hidden = NO;
    
    _vAddressLabel.hidden = NO;
}

- (void)fillContentWithAddress:(Address *)address
{
    if (address.id > 0) {
        Area *area = address.area;
        _vReciverLabel.text = address.fullname;
        _vMobileLabel.text = address.telephone;
        _vAddressLabel.text = [NSString stringWithFormat:@"%@ %@", area.path_names_4print, address.detail];
        [self showAddressItems];
    } else {
        [self showNoAddressItems];
    }
}

- (void)clickGridBtn
{
    [self.delegate doClickAddressCell];
}

@end
