//
//  OrderListCell.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 16/3/14.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface OrderListCell : UITableViewCell

+ (CGFloat)height;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier order:(Order *)order;

@end
