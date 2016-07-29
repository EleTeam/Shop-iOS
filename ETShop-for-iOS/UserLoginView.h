//
//  UserLoginView.h
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

@protocol UserLoginViewDelegate <NSObject>

- (void)doClickLoginBtnWithMobile:(NSString *)mobile password:(NSString *)password;

- (void)doClickForgetBtn;

- (void)doClickRegisterBtn;

@end


@interface UserLoginView : UIView

@property (nonatomic, weak) id<UserLoginViewDelegate> delegate;

@end
