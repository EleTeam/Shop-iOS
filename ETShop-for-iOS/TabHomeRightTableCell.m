//
//  TabHomeRightTableCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "TabHomeRightTableCell.h"

@interface TabHomeRightTableCell ()
{
    UIImageView *_productImage;
    UILabel     *_nameLabel;
    UILabel     *_curPriceLabel;
    UILabel     *_oriPriceLabel;
    UILabel     *_reducePriceLabel;
}
@end


@implementation TabHomeRightTableCell

+ (CGFloat)height
{
    return 85;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _productImage = [UIImageView new];
    _productImage.layer.cornerRadius = 3;
    [self addSubview:_productImage];
    [_productImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    _nameLabel = [UILabel new];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_productImage.mas_right).with.offset(10);
        make.top.equalTo(self).with.offset(10);
    }];
    
    _curPriceLabel = [UILabel new];
    _curPriceLabel.font = [UIFont systemFontOfSize:18];
    _curPriceLabel.textColor = kColorMainOrange;
    [self addSubview:_curPriceLabel];
    [_curPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(3);
    }];
    
    _oriPriceLabel = [UILabel new];
    [self addSubview:_oriPriceLabel];
    [_oriPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_curPriceLabel.mas_right).with.offset(20);
        make.bottom.equalTo(_curPriceLabel);
    }];
    _oriPriceLabel.hidden = YES;
    
    _reducePriceLabel = [UILabel new];
    _reducePriceLabel.font = [UIFont systemFontOfSize:14];
    _reducePriceLabel.textColor = kColorMainOrange;
    _reducePriceLabel.layer.borderWidth = 1;
    _reducePriceLabel.layer.borderColor = kColorMainOrange.CGColor;
    _reducePriceLabel.layer.cornerRadius = 3;
    [self addSubview:_reducePriceLabel];
    [_reducePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_curPriceLabel.mas_bottom).with.offset(3);
    }];
    _reducePriceLabel.hidden = YES;
    
    return self;
}

- (void)fillContentWithProduct:(Product *)product
{
    _nameLabel.text = product.name;
    [_productImage sd_setImageWithURL:[NSURL URLWithString:product.image_small] placeholderImage:[UIImage imageNamed:@"image_holder"]];
    
    float reduce_price = [product.price floatValue] - [product.featured_price floatValue];
    if ([product.featured_price floatValue] > 0 && reduce_price > 0) {
        _curPriceLabel.text = [FormatUtil formatPrice:product.featured_price];
        _reducePriceLabel.text = [NSString stringWithFormat:@"立减%@元", [FormatUtil formatFloatPrice:reduce_price]];
        
        //划线居中
        NSDictionary *attrDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont systemFontOfSize:15], NSFontAttributeName,
                                  kColorMainGrey,               NSForegroundColorAttributeName,
                                  [NSNumber numberWithInteger:NSUnderlineStyleSingle],   NSStrikethroughStyleAttributeName, nil];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[FormatUtil formatPrice:product.price] attributes:attrDict];
        _oriPriceLabel.attributedText = attrStr;
        
        _oriPriceLabel.hidden = NO;
        _reducePriceLabel.hidden = NO;
    } else {
        _curPriceLabel.text = [FormatUtil formatPrice:product.price];
        //必须重写以下控件，否则会保留以前的数据
        _oriPriceLabel.text = nil;
        _reducePriceLabel.text = nil;
        
        _oriPriceLabel.hidden = YES;
        _reducePriceLabel.hidden = YES;
    }
}

@end
