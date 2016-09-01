//
//  PreorderPayCell.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/11/01.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>
#import "Preorder.h"

@protocol PreorderPayCellDelegate <NSObject>

- (void)doSelectPayType:(NSNumber *)pay_type;

@end


@interface PreorderPayCell : UITableViewCell

@property (nonatomic, weak) id<PreorderPayCellDelegate> delegate;

+ (CGFloat)height;

- (void)setPayType:(NSNumber *)pay_type;

@end
