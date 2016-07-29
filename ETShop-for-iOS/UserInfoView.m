//
//  UserInfoView.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 16/3/14.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserInfoView.h"

@interface UserInfoView ()
{
    UIView *_gridMobile;
    UIView *_gridLevel;
    
    UILabel *_mobileTitle;
    UILabel *_mobileLabel;
    
    UILabel *_levelTitle;
    UILabel *_levelLabel;
}

@end

@implementation UserInfoView

- (instancetype)initWithFrame:(CGRect)frame user:(User *)user
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    _gridMobile = [UIView new];
    _gridLevel = [UIView new];
    [self addSubview:_gridMobile];
    [self addSubview:_gridLevel];
    [_gridMobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.right.equalTo(self).with.offset(8);
        make.top.equalTo(self).with.offset(10);
        make.height.mas_equalTo(30);
    }];
    [_gridLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gridMobile);
        make.right.equalTo(_gridMobile);
        make.top.equalTo(_gridMobile.mas_bottom).with.offset(10);
        make.height.equalTo(_gridMobile);
    }];
    
    _mobileTitle = [UILabel new];
    _mobileTitle.text = @"手机号:";
    [_gridMobile addSubview:_mobileTitle];
    [_mobileTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gridMobile);
        make.centerY.equalTo(_gridMobile);
        make.width.mas_equalTo(70);
    }];
    
    _mobileLabel = [UILabel new];
    _mobileLabel.text = user.mobile;
    [_gridMobile addSubview:_mobileLabel];
    [_mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mobileTitle.mas_right);
        make.centerY.equalTo(_gridMobile);
        make.width.mas_equalTo(200);
    }];
    
    _levelTitle = [UILabel new];
    _levelTitle.text = @"级别:";
    [_gridLevel addSubview:_levelTitle];
    [_levelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gridLevel);
        make.centerY.equalTo(_gridLevel);
        make.width.equalTo(_mobileTitle);
    }];
    
    _levelLabel = [UILabel new];
    _levelLabel.text = user.level;
    [_gridLevel addSubview:_levelLabel];
    [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mobileLabel);
        make.centerY.equalTo(_gridLevel);
        make.width.mas_equalTo(_mobileLabel);
    }];
    
    return self;
}

@end
