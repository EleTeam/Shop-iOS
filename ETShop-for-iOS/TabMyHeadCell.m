//
//  TabMyHeadCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "TabMyHeadCell.h"

@interface TabMyHeadCell ()
{
    UIImageView *_vImage;
    UILabel *_vName;
    UILabel *_vLevel;
    UILabel *_vNotLogin;
}

@end

@implementation TabMyHeadCell

+ (CGFloat)height
{
    return 90;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // set cell background image
    UIImageView *vBgImage = [UIImageView new];
    vBgImage.image = [UIImage imageNamed:@"head_bg"];
//    self.backgroundView = vBgImage;
    self.backgroundColor = [UIColor clearColor];
    [self setBackgroundView:vBgImage];
    
    //_vImage
    CGFloat vImageWidth = 60;
    CGFloat vImageHeight = 60;
    _vImage = [UIImageView new];
    _vImage.image = [UIImage imageNamed:@"head"];
    [self addSubview:_vImage];
    [_vImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(vImageWidth);
        make.height.mas_equalTo(vImageHeight);
    }];
    
    //_vName
    _vName = [UILabel new];
    _vName.textColor = kColorWhite;
    _vName.hidden = YES;
    [self addSubview:_vName];
    [_vName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vImage.mas_right).with.offset(10);
        make.top.equalTo(self).with.offset(25);
    }];
    
    //_vLevel
    _vLevel = [UILabel new];
    _vLevel.textColor = kColorWhite;
    _vLevel.textAlignment = NSTextAlignmentCenter;
    _vLevel.layer.borderWidth = 1;
    _vLevel.layer.borderColor = kColorWhite.CGColor;
    _vLevel.layer.cornerRadius = 3;
    _vLevel.hidden = YES;
    [self addSubview:_vLevel];
    [_vLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vName);
        make.top.equalTo(_vName.mas_bottom).with.offset(2);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
    }];
    
    //_vNotLogin
    _vNotLogin = [UILabel new];
    _vNotLogin.textColor = kColorMainRed;
    _vNotLogin.font = [UIFont systemFontOfSize:19];
    _vNotLogin.hidden = YES;
    [self addSubview:_vNotLogin];
    [_vNotLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vLevel);
        make.centerY.equalTo(self);
    }];
    
    [self fillContentByStorage];
    
    return self;
}

- (void)fillContentWithUser:(User *)user
{
    if (user.id > 0) {
        _vName.text = user.mobile;
        _vName.hidden = NO;
        _vLevel.text = user.level_label;
        _vLevel.hidden = NO;
        _vNotLogin.hidden = YES;
    } else {
        _vNotLogin.text = @"登录/注册";
        _vName.hidden = YES;
        _vLevel.hidden = YES;
        _vNotLogin.hidden = NO;
    }
}

- (void)fillContentByStorage
{
    NSNumber *user_id = [StorageUtil getUserId];
    NSString *user_mobile = [StorageUtil getUserMobile];
    NSNumber *user_level = [StorageUtil getUserLevel];
    NSString *user_level_label = [StorageUtil getUserLevelLabel];
    User *user = [User new];
    user.id = user_id;
    user.mobile = user_mobile;
    user.level = user_level;
    user.level_label = user_level_label;
    [self fillContentWithUser:user];
}

@end
