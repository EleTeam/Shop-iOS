//
//  UserRegisterSuccessView.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/21.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserRegisterSuccessView.h"

@interface UserRegisterSuccessView ()
{
    UILabel *_vNote1;
    UILabel *_vNote2;
    UILabel *_vLoginName;
    UILabel *_vPassword;
    UIButton *_vShoppingBtn;
}
@end


@implementation UserRegisterSuccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    _vNote1 = [UILabel new];
    _vNote1.text = @"恭喜，您已注册成功！";
    [self addSubview:_vNote1];
    [_vNote1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20);
    }];
    
    _vNote2 = [UILabel new];
    _vNote2.text = @"请保管好您的登录信息！";
    [self addSubview:_vNote2];
    [_vNote2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vNote1);
        make.top.equalTo(_vNote1.mas_bottom).with.offset(10);
    }];
    
    _vLoginName = [UILabel new];
    [self addSubview:_vLoginName];
    [_vLoginName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vNote2);
        make.top.equalTo(_vNote2.mas_bottom).with.offset(10);
    }];
    
    _vPassword = [UILabel new];
    [self addSubview:_vPassword];
    [_vPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vLoginName);
        make.top.equalTo(_vLoginName.mas_bottom).with.offset(10);
    }];
    
    //_vShoppingBtn
    _vShoppingBtn = [UIButton new];
    [_vShoppingBtn setTitle:@"去购物" forState:UIControlStateNormal];
    [_vShoppingBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_vShoppingBtn setBackgroundColor:kColorMainRed];
    _vShoppingBtn.layer.cornerRadius = 4;
    [self addSubview:_vShoppingBtn];
    [_vShoppingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vPassword);
        make.right.equalTo(self).with.offset(-20);
        make.top.equalTo(_vPassword.mas_bottom).with.offset(20);
    }];
    
    [_vShoppingBtn addTarget:self action:@selector(clickShoppingBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)fillContentWithLoginName:(NSString *)loginName password:(NSString *)password
{
    _vLoginName.text = [NSString stringWithFormat:@"手机号：%@", loginName];
    _vPassword.text = [NSString stringWithFormat:@"密码是：%@", password];
}

- (void)clickShoppingBtn
{
    [self.delegate doClickShoppingBtn];
}

@end
