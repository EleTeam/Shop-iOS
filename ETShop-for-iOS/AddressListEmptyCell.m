//
//  AddressListEmptyCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/10/23.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "AddressListEmptyCell.h"

@interface AddressListEmptyCell () 
{
    UIButton *_vGridBtn;
    UIImageView *_vImage;
    UILabel *_vTitle;
}

@end

@implementation AddressListEmptyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    _vGridBtn = [UIButton new];
    [self addSubview:_vGridBtn];
    [_vGridBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.height.equalTo(self);
    }];
    
    _vImage = [UIImageView new];
    _vImage.image = [UIImage imageNamed:@"icon_person_address"];
    [_vGridBtn addSubview:_vImage];
    [_vImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vGridBtn).with.offset(20);
        make.centerY.equalTo(_vGridBtn);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    _vTitle = [UILabel new];
    _vTitle.text = @"添加收货地址";
    [_vGridBtn addSubview:_vTitle];
    [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vImage.mas_right).with.offset(8);
        make.centerY.equalTo(_vGridBtn);
    }];
    
    [_vGridBtn addTarget:self action:@selector(clickEmptyGrid) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)clickEmptyGrid
{
    [self.delegate doClickAddressAddBtn];
}

@end
