//
//  TabMyCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "TabMyCell.h"

@interface TabMyCell ()
{
        UIImageView *_vImage;
        UILabel *_vTitle;
}
@end

@implementation TabMyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageNamed:(NSString *)imageNamed title:(NSString *)title
{
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (!self) return nil;
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
        _vImage = [UIImageView new];
        _vImage.image = [UIImage imageNamed:imageNamed];
        [self addSubview:_vImage];;
        [_vImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(16);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(25);
        }];
    
        _vTitle = [UILabel new];
        _vTitle.text = title;
        [self addSubview:_vTitle];
        [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_vImage.mas_right).with.offset(10);
            make.centerY.equalTo(self);
        }];
        
        return self;
}

@end
