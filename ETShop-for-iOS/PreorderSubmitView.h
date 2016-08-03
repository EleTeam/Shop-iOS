//
//  PreorderSubmitView.h
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

@protocol PreorderSubmitViewDelegate <NSObject>

- (void)doClickSubmitBtn;

@end


@interface PreorderSubmitView : UIView

@property (nonatomic, weak) id<PreorderSubmitViewDelegate> delegate;

+ (CGFloat)height;

- (void)fillContentWithPreorder:(Preorder *)preorder;

@end
