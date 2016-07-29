//
//  AddressListEmptyCell.h
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
#import "AddressAddBtn.h"

@interface AddressListEmptyCell : UITableViewCell

@property (nonatomic, weak) id<AddressAddBtnDelegate> delegate;

@end
