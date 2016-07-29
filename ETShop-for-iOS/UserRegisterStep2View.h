//
//  UserRegisterStep2View.h
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

@protocol UserRegisterStep2ViewDelegate <NSObject>

- (void)doClickNextBtnWithPassword:(NSString *)password;

@end


@interface UserRegisterStep2View : UIView

@property (nonatomic, weak) id<UserRegisterStep2ViewDelegate> delegate;

@end
