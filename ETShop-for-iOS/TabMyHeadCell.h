//
//  TabMyHeadCell.h
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
#import "User.h"

@protocol TabMyHeadCellDelegate <NSObject>

@end


@interface TabMyHeadCell : UITableViewCell

+ (CGFloat)height;

- (void)fillContentWithUser:(User *)user;

@end
