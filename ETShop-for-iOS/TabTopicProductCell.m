//
//  TabTopicProductCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "TabTopicProductCell.h"
#import "Product.h"

@interface TabTopicProductCell ()
{
    UIImageView *_vImage;
    UILabel *_vTitle;
    UILabel *_vShortDesc;
    PriceLabel *_vCurPrice;
    PriceLabel *_vOriPrice;
    PriceLabel *_vReducePrice;
    UILabel *_vSaleNum;
    UILabel *_vSeperator;
}
@end


@implementation TabTopicProductCell

+ (CGFloat)height
{
    return 100;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        
        CGFloat margin = 8;
        CGFloat leftMargin = 8;
        CGFloat rightMargin = 8;
        CGFloat topMargin = 12;
        
        //_vImage
        CGFloat vImageWidth = 60;
        CGFloat vImageHeight = 60;
        _vImage = [UIImageView new];
        _vImage.layer.cornerRadius = 5;
        _vImage.image = [UIImage imageNamed:@"image_holder"];
        [self addSubview:_vImage];
        
        [_vImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftMargin);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(vImageWidth);
            make.height.mas_equalTo(vImageHeight);
        }];
        
        //_vTitle
        _vTitle = [UILabel new];
        [self addSubview:_vTitle];
        
        [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_vImage.mas_right).with.offset(margin);
            make.top.mas_equalTo(topMargin);
        }];
        
        //_vShortDesc
        _vShortDesc = [UILabel new];
        _vShortDesc.font = [UIFont systemFontOfSize:13];
        _vShortDesc.textColor = kColorMainGrey;
        _vShortDesc.numberOfLines = 2;
        [self addSubview:_vShortDesc];
        
        CGFloat vShortDescWidth = (self.frame.size.width - 8 - vImageWidth - margin - rightMargin);
        [_vShortDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_vTitle);
            make.top.equalTo(_vTitle.mas_bottom).with.offset(2);
            make.width.mas_equalTo(vShortDescWidth);
        }];
        
        //_vCurPrice
        _vCurPrice = [PriceLabel new];
        [self addSubview:_vCurPrice];
        
        [_vCurPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_vTitle);
            make.top.equalTo(_vShortDesc.mas_bottom).with.offset(2);
        }];
        
        //_vOriPrice
        _vOriPrice = [PriceLabel new];
        [self addSubview:_vOriPrice];
        
        [_vOriPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_vCurPrice.mas_right).with.offset(margin);
            make.bottom.equalTo(_vCurPrice.mas_bottom);
        }];
        
        //_vReducePrice
        _vReducePrice = [PriceLabel new];
        [self addSubview:_vReducePrice];
        
        [_vReducePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-2 * margin);
            make.bottom.equalTo(_vOriPrice.mas_bottom);
        }];
        
        //_vSaleNum
        _vSaleNum = [UILabel new];
        _vSaleNum.font = [UIFont systemFontOfSize:14];
        _vSaleNum.textColor = kColorMainOrange;
        _vSaleNum.layer.borderColor = kColorMainOrange.CGColor;
        _vSaleNum.layer.borderWidth = 1;
        _vSaleNum.layer.cornerRadius = 3;
        [self addSubview:_vSaleNum];
        
        [_vSaleNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-2 * margin);
            make.bottom.equalTo(_vOriPrice.mas_bottom);
        }];
        
        //_vSeperator
        _vSeperator = [UILabel new];
        _vSeperator.backgroundColor = [UIColor hexColor:@"d8d8d8"];
        [self addSubview:_vSeperator];
        
        [_vSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom).with.offset(-1);
            make.leading.equalTo(self.mas_leading);
            make.trailing.equalTo(self.mas_trailing);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)fillContentWithProduct:(Product *)product tagName:(NSString *)tagName;
{
    if (!product || !product.id) {
        return;
    }
    
    [_vImage sd_setImageWithURL:[NSURL URLWithString:product.image_small]];
    _vTitle.text = product.name;
    _vShortDesc.text = product.short_description;
    
    float reducePrice = [product.price floatValue] - [product.featured_price floatValue];
    if ([product.featured_price floatValue] > 0 && reducePrice > 0) {
        [_vCurPrice setCurPrice:product.featured_price];
        [_vOriPrice setOriPrice:product.price];
        if ([@"featuredTag" isEqualToString:tagName] || [@"topicTag" isEqualToString:tagName]) {
            [_vReducePrice setReducePrice:[NSNumber numberWithFloat:reducePrice]];
        }
    } else {
        [_vCurPrice setCurPrice:product.price];
        _vOriPrice.text = nil;
        _vOriPrice.attributedText = nil;
        _vReducePrice.text = nil;
    }
    
    
    if ([@"featuredTag" isEqualToString:tagName] || [@"topicTag" isEqualToString:tagName]) {
        _vSaleNum.text = nil;
    }
    
    if ([@"topSaleTag" isEqualToString:tagName]) {
        _vSaleNum.text = [NSString stringWithFormat:@"已售出%@份", product.total_count];
        _vReducePrice.text = nil;
    }
}

@end
