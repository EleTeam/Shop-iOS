//
//  TabCartItemCell.h
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
#import "CartItem.h"
#import "CouponUser.h"

@class TabCartItemCell;

@protocol TabCartItemCellDelegate <NSObject>

- (void)doClickMinus:(TabCartItemCell *)sender;

- (void)doClickPlus:(TabCartItemCell *)sender;

- (void)doClickDelete:(TabCartItemCell *)sender;

- (void)doClickSelect:(TabCartItemCell *)sender is_selected:(NSNumber *)is_selected;

@end


@interface TabCartItemCell : UITableViewCell

@property (nonatomic, copy) NSNumber *cartItemId;

@property (nonatomic, copy) NSNumber *is_selected;

@property (nonatomic, weak) id<TabCartItemCellDelegate> delegate;

+ (CGFloat)height;

- (void)fillContentWithCartItem:(CartItem *)cartItem couponUser:(NSArray *)couponUsers total_price:(NSNumber *)total_price;

//设置购物车项的数量
- (void) setCount:(NSNumber *)count;

//获得购物车项的数量
- (NSNumber *)getCount;

//设置是否选择项的图片
- (void)setIsSelectedBy:(NSNumber *)is_selected;

@end
