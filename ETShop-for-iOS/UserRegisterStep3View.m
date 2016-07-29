//
//  UserRegisterStep3View.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/21.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserRegisterStep3View.h"

@interface UserRegisterStep3View ()
{
    UIImageView *_vCodeIcon;
    UITextField *_vCodeText;
    UILabel *_vUnderline;
    UIButton *_vNextBtn;
}
@end


@implementation UserRegisterStep3View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = kColorWhite;
    
    //_vCodeIcon
    _vCodeIcon = [UIImageView new];
    _vCodeIcon.image = [UIImage imageNamed:@"icon_link"];
    [self addSubview:_vCodeIcon];
    [_vCodeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.top.equalTo(self).with.offset(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    //_vCodeText
    _vCodeText = [UITextField new];
    _vCodeText.placeholder = @"请输入验证码";
    _vCodeText.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:_vCodeText];
    [_vCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vCodeIcon.mas_right).with.offset(10);
        make.top.equalTo(_vCodeIcon);
        make.right.equalTo(self);
    }];
    
    //_vUnderline
    _vUnderline = [UILabel new];
    _vUnderline.backgroundColor = [UIColor hexColor:@"e1e1e1"];
    [self addSubview:_vUnderline];
    [_vUnderline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(_vCodeIcon.mas_bottom).with.offset(10);
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
    NSString *code = _vCodeText.text;
    [self.delegate doClickNextBtnWithCode:code];
}

@end
