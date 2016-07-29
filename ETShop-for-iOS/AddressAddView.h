//
//  AddressAddView.h
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

@protocol AddressAddViewDelegate <NSObject>

- (void)doClickSaveBtnWithAreaId:(NSString *)areaId
                       telephone:(NSString *)telephone
                          detail:(NSString *)detail
                        fullname:(NSString *)fullname;

@end

@interface AddressAddView : UIView

@property (nonatomic, weak) id<AddressAddViewDelegate> delegate;

- (void)setChainedAreas:(NSArray *)chainedAreas;

@end
