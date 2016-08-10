//
//  AddressListCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/10/23.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "AddressListCell.h"

@interface AddressListCell ()
{
    Address *_address;
    
    UIButton *_vGridLeft;
    UIButton *_vGridRight;
    
    UIImageView *_vSelectImage;
    UILabel *_vName;
    UILabel *_vMobile;
    UILabel *_vAddress;
    UILabel *_vEditSeperator;
    UIImageView *_vEditImage;
}

@end

@implementation AddressListCell

+ (CGFloat)height
{
    return 84;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setBackgroundColor:kColorWhite];
    
    CGFloat gridRightWidth = 38;
    CGFloat gridLeftWidth = self.frame.size.width - gridRightWidth;
    _vGridLeft = [UIButton new];
    _vGridRight = [UIButton new];
    [self addSubview:_vGridLeft];
    [self addSubview:_vGridRight];
    [_vGridLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(gridLeftWidth);
        make.height.equalTo(self);
    }];
    [_vGridRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vGridLeft.mas_right);
        make.top.equalTo(self);
        make.width.mas_equalTo(gridRightWidth);
        make.height.equalTo(self);
    }];
    
    //_vSelectImage
    _vSelectImage =  [UIImageView new];
    [_vGridLeft addSubview:_vSelectImage];
    [_vSelectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vGridLeft).with.offset(8);
        make.centerY.equalTo(_vGridLeft);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    _vName = [UILabel new];
    [_vGridLeft addSubview:_vName];
    [_vName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vSelectImage.mas_right).with.offset(16);
        make.top.equalTo(_vGridLeft).with.offset(8);
    }];
    
    _vMobile = [UILabel new];
    [_vGridLeft addSubview:_vMobile];
    [_vMobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vName.mas_right).with.offset(12);
        make.top.equalTo(_vName);
        make.height.equalTo(_vName);
    }];
    
    _vAddress = [UILabel new];
    _vAddress.numberOfLines = 2;
    _vAddress.lineBreakMode = NSLineBreakByWordWrapping;
    [_vGridLeft addSubview:_vAddress];
    [_vAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vName);
        make.right.equalTo(_vGridLeft.mas_right).with.offset(-4);
        make.top.equalTo(_vName.mas_bottom).with.offset(4);
    }];
    
    _vEditSeperator = [UILabel new];
    _vEditSeperator.backgroundColor = kColorUnderline;
    [_vGridRight addSubview:_vEditSeperator];
    [_vEditSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vGridRight);
        make.centerY.equalTo(_vGridRight);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(20);
    }];
    
    _vEditImage = [UIImageView new];
    _vEditImage.image = [UIImage imageNamed:@"operator_trash"];
    [_vGridRight addSubview:_vEditImage];
    [_vEditImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_vGridRight);
        make.centerY.equalTo(_vGridRight).with.offset(8);
        make.width.mas_equalTo(34);
        make.height.mas_equalTo(34);
    }];
    
    [_vGridLeft addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)fillContentWithAddress:(Address *)address
{
    if (address.id > 0) {
        _address = address;
        _vName.text = address.fullname;
        _vMobile.text = address.telephone;
        Area *area = address.area;
        _vAddress.text = [NSString stringWithFormat:@"%@ %@", area.path_names_4print, address.detail];
        
        if ([address.is_default boolValue]) {
            [self setSelected];
        } else {
            [self setUnselected];
        }
    }
}

//设置选择项的图片
- (void)setSelected
{
    _vSelectImage.image = [UIImage imageNamed:@"operator_selected_yes"];
}

//设置未选择项的图片
- (void)setUnselected
{
    _vSelectImage.image = [UIImage imageNamed:@"operator_selected_no"];
}

- (void)selectAddress
{
    [self.delegate doSelectAddress:_address];
}
@end
