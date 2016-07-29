//
//  PreorderCouponCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/11/01.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "PreorderCouponCell.h"

@interface PreorderCouponCell () <UITextFieldDelegate>
{
    UILabel *_vTitle;
}
@end

@implementation PreorderCouponCell

+ (CGFloat)height
{
    return 44;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _vTitle = [UILabel new];
    _vTitle.text = @"优惠红包";
    _vTitle.textColor = kColorMainOrange;
    [self addSubview:_vTitle];
    [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.centerY.equalTo(self);
    }];
    
    return self;
}

@end
