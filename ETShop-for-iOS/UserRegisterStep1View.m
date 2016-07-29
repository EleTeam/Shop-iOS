//
//  UserRegisterStep1View.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/21.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserRegisterStep1View.h"

@interface UserRegisterStep1View ()
{
    UIImageView *_vMobileIcon;
    UITextField *_vMobileText;
    UILabel *_vUnderline;
    UIButton *_vNextBtn;
}
@end


@implementation UserRegisterStep1View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = kColorWhite;
    
    //_vMobileIcon
    _vMobileIcon = [UIImageView new];
    _vMobileIcon.image = [UIImage imageNamed:@"icon_person"];
    [self addSubview:_vMobileIcon];
    [_vMobileIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.top.equalTo(self).with.offset(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    //_vMobileText
    _vMobileText = [UITextField new];
    _vMobileText.placeholder = @"请输入手机号";
    _vMobileText.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:_vMobileText];
    [_vMobileText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vMobileIcon.mas_right).with.offset(10);
        make.top.equalTo(_vMobileIcon);
        make.right.equalTo(self);
    }];
    
    //_vUnderline
    _vUnderline = [UILabel new];
    _vUnderline.backgroundColor = [UIColor hexColor:@"e1e1e1"];
    [self addSubview:_vUnderline];
    [_vUnderline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(_vMobileIcon.mas_bottom).with.offset(10);
        make.height.mas_equalTo(1);
    }];
    
    //_vNextBtn
    _vNextBtn = [UIButton new];
    [_vNextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_vNextBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_vNextBtn setBackgroundColor:kColorMainRed];
    _vNextBtn.layer.cornerRadius = 4;
    [self addSubview:_vNextBtn];
    [_vNextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.right.equalTo(self).with.offset(-8);
        make.top.equalTo(_vUnderline).with.offset(20);
    }];
    
    [_vNextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)clickNextBtn
{
    NSString *mobile = _vMobileText.text;
    [self.delegate doClickNextBtnWithMobile:mobile];
}

@end
