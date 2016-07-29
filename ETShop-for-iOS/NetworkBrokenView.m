//
//  NetworkBrokenView.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/26.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "NetworkBrokenView.h"

@interface NetworkBrokenView ()
{
    UIButton    *_gridBtn;
    UIImageView *_wifiImage;
    UILabel     *_brokenTitle;
}

@end

@implementation NetworkBrokenView

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _gridBtn = [UIButton new];
    [self addSubview:_gridBtn];
    [_gridBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    _wifiImage = [UIImageView new];
    _wifiImage.image = [UIImage imageNamed:@"wifi_broken"];
    [_gridBtn addSubview:_wifiImage];
    [_wifiImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_gridBtn);
        make.bottom.equalTo(_gridBtn.mas_centerY).with.offset(-10);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(100);
    }];

    _brokenTitle = [UILabel new];
    _brokenTitle.textColor = kColorMainOrange;
    _brokenTitle.numberOfLines = 3;
    _brokenTitle.lineBreakMode = NSLineBreakByWordWrapping;
    _brokenTitle.text = @"网络异常，请检查网络后，点击这个图标获取数据";
    [_gridBtn addSubview:_brokenTitle];
    [_brokenTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_gridBtn);
        make.top.equalTo(_gridBtn.mas_centerY).with.offset(10);
        make.left.equalTo(_gridBtn).with.offset(8);
        make.right.equalTo(_gridBtn).with.offset(-8);
    }];
    
    [_gridBtn addTarget:self action:@selector(clickGridBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)clickGridBtn
{
    [self.delegate doClickNetworkBrokenView];
}

@end
