//
//  ProductAttrCell.h
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
#import "ProductForm.h"

/**
 * 属性视图对象
 * 这个对象会改变productForm表单的属性值
 */

@interface ProductAttrCell : UITableViewCell

//高度会根据产品的属性个数自动变化
+ (CGFloat)heightWithProduct:(Product *)product;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier product:(Product *)product productForm:(ProductForm *)productForm;

@end
