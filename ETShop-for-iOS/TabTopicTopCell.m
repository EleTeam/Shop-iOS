//
//  TabTopicTopCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "TabTopicTopCell.h"

@interface TabTopicTopCell ()
{
    //底部栏划分为3个方格
    UIView *grid1;
    UIView *grid2;
    UIView *grid3;
    
    UILabel *_featuredLabel;
    UILabel *_featuredLine;
    
    UILabel *_topicLabel;
    UILabel *_topicLine;
    
    UILabel *_topSaleLabel;
    UILabel *_topSaleLine;
}
@end


@implementation TabTopicTopCell

+ (CGFloat)height
{
    return 38;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        //底部栏划分为3个方格
        CGFloat height = [TabTopicTopCell height];
        CGFloat underlineHeight = 2;
        CGFloat labelHeight = height - underlineHeight;
        CGFloat gridWidth = self.frame.size.width / 3;
        
        grid1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, gridWidth, height)];
        grid2 = [[UIView alloc] initWithFrame:CGRectMake(gridWidth, 0, gridWidth, height)];
        grid3 = [[UIView alloc] initWithFrame:CGRectMake(gridWidth * 2, 0, gridWidth, height)];
        grid1.backgroundColor = kColorWhite;
        grid2.backgroundColor = kColorWhite;
        grid3.backgroundColor = kColorWhite;
        
        [self addSubview:grid1];
        [self addSubview:grid2];
        [self addSubview:grid3];
        
        //grid1
        _featuredLabel = [UILabel new];
        _featuredLabel.textColor = kColorMainOrange;
        _featuredLabel.textAlignment = NSTextAlignmentCenter;
        _featuredLabel.text = @"天天优惠";
        _featuredLabel.backgroundColor = kColorBackgound;
        [grid1 addSubview:_featuredLabel];
        
        [_featuredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(grid1.mas_centerX);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(labelHeight);
            make.width.mas_equalTo(gridWidth);
        }];
        
        _featuredLine = [UILabel new];
        _featuredLine.backgroundColor = kColorMainOrange;
        [grid1 addSubview:_featuredLine];
        
        [_featuredLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(labelHeight);
            make.height.mas_equalTo(underlineHeight);
            make.width.mas_equalTo(gridWidth);
        }];
        
        //grid2
        _topicLabel = [UILabel new];
        _topicLabel.textColor = kColorMainBlack;
        _topicLabel.textAlignment = NSTextAlignmentCenter;
        _topicLabel.text = @"为你精选";
        _topicLabel.backgroundColor = kColorBackgound;
        [grid2 addSubview:_topicLabel];
        
        [_topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(grid2.mas_centerX);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(labelHeight);
            make.width.mas_equalTo(gridWidth);
        }];
        
        _topicLine = [UILabel new];
        _topicLine.backgroundColor = kColorMainOrange;
        _topicLine.hidden = YES;
        [grid2 addSubview:_topicLine];
        
        [_topicLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(labelHeight);
            make.height.mas_equalTo(underlineHeight);
            make.width.mas_equalTo(gridWidth);
        }];

        //grid3
        _topSaleLabel = [UILabel new];
        _topSaleLabel.textColor = kColorMainBlack;
        _topSaleLabel.textAlignment = NSTextAlignmentCenter;
        _topSaleLabel.text = @"亲的最爱";
        _topSaleLabel.backgroundColor = kColorBackgound;
        [grid3 addSubview:_topSaleLabel];
        
        [_topSaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(grid3.mas_centerX);
            make.height.mas_equalTo(labelHeight);
            make.width.mas_equalTo(gridWidth);
        }];
        
        _topSaleLine = [UILabel new];
        _topSaleLine.backgroundColor = kColorMainOrange;
        _topSaleLine.hidden = YES;
        [grid3 addSubview:_topSaleLine];
        
        [_topSaleLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(labelHeight);
            make.height.mas_equalTo(underlineHeight);
            make.width.mas_equalTo(gridWidth);
        }];
        
        //添加点击事件监控
        UITapGestureRecognizer *grid1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFeaturedProducts)];
        UITapGestureRecognizer *grid2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTopicProducts)];
        UITapGestureRecognizer *grid3Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTopSaleProducts)];
        [grid1 addGestureRecognizer:grid1Tap];
        [grid2 addGestureRecognizer:grid2Tap];
        [grid3 addGestureRecognizer:grid3Tap];
    }
    return self;
}

- (void)showFeaturedProducts
{
    _featuredLabel.textColor = kColorMainOrange;
    _topicLabel.textColor = kColorMainBlack;
    _topSaleLabel.textColor = kColorMainBlack;
    
    _featuredLine.hidden = NO;
    _topicLine.hidden = YES;
    _topSaleLine.hidden = YES;
    
    [self.delegate doClickFeaturedTag];
}

- (void)showTopicProducts
{
    _topicLabel.textColor = kColorMainOrange;
    _featuredLabel.textColor = kColorMainBlack;
    _topSaleLabel.textColor = kColorMainBlack;
    
    _featuredLine.hidden = YES;
    _topicLine.hidden = NO;
    _topSaleLine.hidden = YES;
    
    [self.delegate doClickTopicTag];
}

- (void)showTopSaleProducts
{
    _topSaleLabel.textColor = kColorMainOrange;
    _featuredLabel.textColor = kColorMainBlack;
    _topicLabel.textColor = kColorMainBlack;
    
    _featuredLine.hidden = YES;
    _topicLine.hidden = YES;
    _topSaleLine.hidden = NO;
    
    [self.delegate doClickTopSaleTag];
}

@end
