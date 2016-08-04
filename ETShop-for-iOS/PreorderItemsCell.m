//
//  PreorderItemsCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/11/01.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "PreorderItemsCell.h"
#import "PreorderItem.h"
#import "PreorderItemView.h"

@interface PreorderItemsCell ()
{
    UILabel *_vTitle;
}

@end


@implementation PreorderItemsCell

+ (CGFloat)heightWithPreorderItems:(NSArray *)preorderItems
{
    return 30 + ([PreorderItemView height] * preorderItems.count) + (preorderItems.count - 1);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier preorderItems:(NSArray *)preorderItems
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _vTitle = [UILabel new];
    _vTitle.text = @"商品列表";
    [self addSubview:_vTitle];
    [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.top.equalTo(self).with.offset(4);
    }];
    
    //产品列表视图
    int i = 0;
    for (PreorderItem *preorderItem in preorderItems) {
        PreorderItemView *vItem = [PreorderItemView new];
        //if (i%2 == 0) vItem.backgroundColor = kColorMainOrange;
        [self addSubview:vItem];
        [vItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self);
            make.leading.equalTo(self);
            make.height.mas_equalTo([PreorderItemView height]);
            make.top.equalTo(_vTitle.mas_bottom).with.offset([PreorderItemView height]*i + i);
        }];
        [vItem setupWithPreorderItem:preorderItem];
        
        if (i < (preorderItems.count-1)) {
            UILabel *vLine = [UILabel new];
            vLine.backgroundColor = kColorUnderline;
            [self addSubview:vLine];
            [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).with.offset(16);
                make.right.equalTo(self).with.offset(-16);
                make.height.mas_equalTo(1);
                make.top.equalTo(_vTitle.mas_bottom).with.offset([PreorderItemView height]*(i+1) + i);
            }];
        }
        i++;
    }
    
    return self;
}

@end
