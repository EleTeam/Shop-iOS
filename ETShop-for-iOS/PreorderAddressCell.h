//
//  PreorderAddressCell.h
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
#import "Address.h"

@protocol PreorderAddressCellDelegate <NSObject>

- (void)doClickAddressCell;

@end


@interface PreorderAddressCell : UITableViewCell

@property (nonatomic, weak) id<PreorderAddressCellDelegate> delegate;

+ (CGFloat)height;

- (void)fillContentWithAddress:(Address *)address;

@end
