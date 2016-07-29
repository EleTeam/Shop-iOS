//
//  TabTopicProductCell.h
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

@class Product;

@interface TabTopicProductCell : UITableViewCell

+ (CGFloat)height;

- (void)fillContentWithProduct:(Product *)product tagName:(NSString *)name;

@end
