//
//  UserRegisterStep2View.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/21.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserRegisterStep2View.h"

@interface UserRegisterStep2View ()
{
    UIImageView *_vPasswordIcon;
    UITextField *_vPasswordText;
    UILabel *_vUnderline;
    UIButton *_vNextBtn;
}
@end


@implementation UserRegisterStep2View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = kColorWhite;
    
    //_vPasswordIcon
    _vPasswordIcon = [UIImageView new];
    _vPasswordIcon.image = [UIImage imageNamed:@"icon_lock"];
    [self addSubview:_vPasswordIcon];
    [_vPasswordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.top.equalTo(self).with.offset(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    //_vPasswordText
    _vPasswordText = [UITextField new];
    _vPasswordText.placeholder = @"请设置密码";
    _vPasswordText.secureTextEntry = YES;
    _vPasswordText.keyboardType = UIKeyboardTypeASCIICapable;
    [self addSubview:_vPasswordText];
    [_vPasswordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vPasswordIcon.mas_right).with.offset(10);
        make.top.equalTo(_vPasswordIcon);
        make.right.equalTo(self);
    }];
    
    //_vUnderline
    _vUnderline = [UILabel new];
    _vUnderline.backgroundColor = [UIColor hexColor:@"e1e1e1"];
    [self addSubview:_vUnderline];
    [_vUnderline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(_vPasswordIcon.mas_bottom).with.offset(10);
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
    NSString *password = _vPasswordText.text;
    [self.delegate doClickNextBtnWithPassword:password];
}

@end
