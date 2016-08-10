//
//  AddressListCell.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/10/23.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>
#import "Address.h"

@protocol AddressListCellDelegate <NSObject>

- (void)doSelectAddress:(Address *)address;

@end

@interface AddressListCell : UITableViewCell

@property (nonatomic, weak) id<AddressListCellDelegate> delegate;

+ (CGFloat)height;

- (void)fillContentWithAddress:(Address *)address;

@end
