//
//  OrderDetailStatusCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/9/18.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "OrderDetailStatusCell.h"

@interface OrderDetailStatusCell ()
{
    UILabel *_statusTitle;
    UILabel *_statusLabel;
}

@end

@implementation OrderDetailStatusCell

+ (CGFloat)height
{
    return 70;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier order:(Order *)order
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _statusTitle = [UILabel new];
    _statusTitle.text = @"订单状态:";
    [self addSubview:_statusTitle];
    [_statusTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.top.equalTo(self).with.offset(10);
    }];
    
    _statusLabel = [UILabel new];
    _statusLabel.text = order.orderStatus.pending_label;
    _statusLabel.textColor = kColorMainOrange;
    [self addSubview:_statusLabel];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_statusTitle.mas_right).with.offset(4);
        make.top.equalTo(_statusTitle);
    }];
    
    return self;
}

@end
