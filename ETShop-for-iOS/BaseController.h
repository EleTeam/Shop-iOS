// The MIT License (MIT)
//
//  BaseController.h
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
#import "UITableView+FDTemplateLayoutCell.h"
#import "NetworkBrokenView.h"

@interface BaseController : UIViewController <NetworkBrokenViewDelegate>

#pragma mark - self.navigationController

- (void)setNavLeftBarButtonItem;

- (void)popSelfController;


#pragma mark - _loadingView show and hide

- (void)showLoadingView;

- (void)hideLoadingView;


#pragma mark - _networkBrokenView show and hide

- (void)showNetworkBrokenView:(void(^)(MASConstraintMaker *))make;

- (void)hideNetworkBrokenView;


#pragma mark - toast

-(void)toast:(NSString *)title;

-(void)toast:(NSString *)title seconds:(int)seconds;

-(void)toastWithError:(NSError *)error;


#pragma mark - 如果用户没有登录则跳到登录页面

- (BOOL)gotoLoginPageIfNotLogin;

@end
