//
//  TabCartSubmitBar.h
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
 * 提交购物车，即登陆用户从购物车添加预购订单
 *  只需要访问kUrlPreorderAdd地址即可，不用在本地提交购物车表单
 */

@protocol TabCartSubmitBarDelegate <NSObject>

- (void)doClickSubmitCartBtn;

@end

@interface TabCartSubmitBar : UIView

@property (nonatomic, weak) id<TabCartSubmitBarDelegate> delegate;

+ (CGFloat)height;

- (void)clickSubmitCartBtn;

- (void)setCartNum:(NSNumber *)cart_num;

@end
