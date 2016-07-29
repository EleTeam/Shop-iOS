//
//  TabMyOrderItemCell.h
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

@protocol TabMyOrderItemCellDelegate <NSObject>

- (void)doGotoOrderListPageWithRoughStatus:(NSString *)roughStatus;

@end


@interface TabMyOrderItemCell : UITableViewCell

@property (nonatomic, weak) id<TabMyOrderItemCellDelegate> delegate;

@end
