//
//  UserRegisterSuccessView.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/21.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>

@protocol UserRegisterSuccessViewDelegate <NSObject>

- (void)doClickShoppingBtn;

@end


@interface UserRegisterSuccessView : UIView

@property (nonatomic, weak) id<UserRegisterSuccessViewDelegate> delegate;

- (void)fillContentWithLoginName:(NSString *)loginName password:(NSString *)password;

@end
