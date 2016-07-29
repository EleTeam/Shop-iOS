//
//  ProductInfoCell.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/29.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>
#import "Product.h"

//产品详情页顶部的产品信息
@interface ProductInfoCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier product:(Product *)product;

+ (CGFloat)heightWithNoShortDescription;

+ (CGFloat)heightWithShortDescription;

@end
