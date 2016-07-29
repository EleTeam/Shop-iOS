//
//  UserLoginView.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/21.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserLoginView.h"

@interface UserLoginView ()
{
    //grid1
    UIImageView *_vMobileIcon;
    UITextField *_vMobileText;
    UILabel *_vGrid1Underline;
    
    //grid2
    UIImageView *_vPasswordIcon;
    UITextField *_vPasswordText;
    UILabel *_vGrid2Underline;
    
    //grid3
    UIButton *_vLoginBtn;
    UIButton *_vForgetBtn;
    UIButton *_vRegisterBtn;
}

@end

@implementation UserLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = kColorWhite;
    
    //划分为三个grid
    UIView *vGrid1 = [UIView new];
    UIView *vGrid2 = [UIView new];
    UIView *vGrid3 = [UIView new];
    [self addSubview:vGrid1];
    [self addSubview:vGrid2];
    [self addSubview:vGrid3];
    [vGrid1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.right.equalTo(self).with.offset(-8);
        make.top.equalTo(self).with.offset(8);
        make.height.mas_equalTo(45);
    }];
    [vGrid2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vGrid1);
        make.right.equalTo(vGrid1);
        make.top.equalTo(vGrid1.mas_bottom);
        make.height.mas_equalTo(vGrid1);
    }];
    [vGrid3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vGrid1);
        make.right.equalTo(vGrid1);
        make.top.equalTo(vGrid2.mas_bottom);
        make.height.mas_equalTo(300);
    }];
    
    //_vMobileIcon
    _vMobileIcon = [UIImageView new];
    _vMobileIcon.image = [UIImage imageNamed:@"icon_person"];
    [vGrid1 addSubview:_vMobileIcon];
    [_vMobileIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vGrid1);
        make.centerY.equalTo(vGrid1);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    //_vMobileText
    _vMobileText = [UITextField new];
    _vMobileText.placeholder = @"手机号";
    _vMobileText.keyboardType = UIKeyboardTypePhonePad;
    [vGrid1 addSubview:_vMobileText];
    [_vMobileText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vMobileIcon.mas_right).with.offset(10);
        make.centerY.equalTo(vGrid1);
        make.right.equalTo(vGrid1);
    }];
    
    //_vGrid1Underline
    _vGrid1Underline = [UILabel new];
    _vGrid1Underline.backgroundColor = [UIColor hexColor:@"e1e1e1"];
    [vGrid1 addSubview:_vGrid1Underline];
    [_vGrid1Underline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vGrid1);
        make.right.equalTo(vGrid1);
        make.top.equalTo(vGrid1.mas_baseline);
        make.height.mas_equalTo(1);
    }];
    
    //_vPasswordIcon
    _vPasswordIcon = [UIImageView new];
    _vPasswordIcon.image = [UIImage imageNamed:@"icon_lock"];
    [vGrid2 addSubview:_vPasswordIcon];
    [_vPasswordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vMobileIcon);
        make.centerY.equalTo(vGrid2);
        make.width.mas_equalTo(_vMobileIcon);
        make.height.mas_equalTo(_vMobileIcon);
    }];
    
    //_vPasswordText
    _vPasswordText = [UITextField new];
    _vPasswordText.placeholder = @"密码";
    _vPasswordText.secureTextEntry = YES;
    _vPasswordText.keyboardType = UIKeyboardTypeASCIICapable;
    [vGrid2 addSubview:_vPasswordText];
    [_vPasswordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vMobileText);
        make.centerY.equalTo(vGrid2);
        make.right.equalTo(vGrid2);
    }];
    
    //_vGrid2Underline
    _vGrid2Underline = [UILabel new];
    _vGrid2Underline.backgroundColor = [UIColor hexColor:@"e1e1e1"];
    [vGrid2 addSubview:_vGrid2Underline];
    [_vGrid2Underline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vGrid2);
        make.right.equalTo(vGrid2);
        make.top.equalTo(vGrid2.mas_baseline);
        make.height.mas_equalTo(1);
    }];
    
    //_vLoginBtn
    _vLoginBtn = [UIButton new];
    [_vLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_vLoginBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_vLoginBtn setBackgroundColor:kColorMainRed];
    _vLoginBtn.layer.cornerRadius = 4;
    [vGrid3 addSubview:_vLoginBtn];
    [_vLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vGrid3);
        make.right.equalTo(vGrid3);
        make.top.equalTo(vGrid3).with.offset(20);
    }];
    
    //_vForgetBtn
    _vForgetBtn = [UIButton new];
    [_vForgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_vForgetBtn setTitleColor:kColorBlue forState:UIControlStateNormal];
    _vForgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [vGrid3 addSubview:_vForgetBtn];
    [_vForgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vGrid3);
        make.top.equalTo(_vLoginBtn.mas_bottom).with.offset(20);
        make.height.mas_equalTo(26);
    }];
    
    //_vRegisterBtn
    _vRegisterBtn = [UIButton new];
    [_vRegisterBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [_vRegisterBtn setTitleColor:kColorBlue forState:UIControlStateNormal];
    _vRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [vGrid3 addSubview:_vRegisterBtn];
    [_vRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(vGrid3);
        make.top.equalTo(_vForgetBtn);
        make.height.equalTo(_vForgetBtn);
    }];
    
    // bind events
    [_vLoginBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [_vForgetBtn addTarget:self action:@selector(clickForgetBtn) forControlEvents:UIControlEventTouchUpInside];
    [_vRegisterBtn addTarget:self action:@selector(clickRegisterBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}


#pragma mark - click actions

- (void)clickLoginBtn;
{
    NSString *mobile = _vMobileText.text;
    NSString *password = _vPasswordText.text;
    
    //去除两端空格
    mobile = [mobile stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    password = [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //去除两端空格和回车
    mobile = [mobile stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    password = [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [self.delegate doClickLoginBtnWithMobile:mobile password:password];
}

- (void)clickForgetBtn
{
    [self.delegate doClickForgetBtn];
}

- (void)clickRegisterBtn
{
    [self.delegate doClickRegisterBtn];
}

@end
