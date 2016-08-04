//
//  OrderSuccessView.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/9/18.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>
#import "Order.h"

@protocol OrderSuccessViewDelegate <NSObject>

- (void)doGotoShopping;

- (void)doViewOrder;

@end


@interface OrderSuccessView : UIView

@property (nonatomic, weak) id<OrderSuccessViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame order:(Order *)order;

@end
