//
//  TabTopicTopCell.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>

/**
 * 优惠页面产品列表的顶部
 */

@protocol TabTopicTopCellDelegate <NSObject>

- (void)doClickFeaturedTag;

- (void)doClickTopicTag;

- (void)doClickTopSaleTag;

@end


@interface TabTopicTopCell : UITableViewCell

@property (nonatomic, weak) id<TabTopicTopCellDelegate> delegate;

+ (CGFloat)height;

@end
