//
//  BaseController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseController.h"
#import "UserLoginController.h"
#import "User.h"
#import "BaseLoadingView.h"
#import "MBProgressHUD.h"

@interface BaseController ()
{
    BaseLoadingView *_loadingView;
    NetworkBrokenView *_networkBrokenView;
}
@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavLeftBarButtonItem];
    self.view.backgroundColor = kColorBackgound;
    
    _loadingView = [[BaseLoadingView alloc] initWithFrame:self.view.bounds];
    _networkBrokenView = [[NetworkBrokenView alloc] init];
    _networkBrokenView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - self.navigationController

- (void)setNavLeftBarButtonItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStyleDone target:self action:@selector(popSelfController)];
}

- (void)popSelfController
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - _loadingView show and hide

- (void)showLoadingView
{
    [self.view addSubview:_loadingView];
}

- (void)hideLoadingView
{
    [_loadingView removeFromSuperview];
}

#pragma mark - _networkBrokenView show and hide

- (void)showNetworkBrokenView:(void(^)(MASConstraintMaker *make))block
{
    [self.view addSubview:_networkBrokenView];
    if (block != nil) {
        [_networkBrokenView mas_makeConstraints:block];
    } else {
        [_networkBrokenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.top.equalTo(self.view);
            make.height.equalTo(self.view);
        }];
    }
}

- (void)hideNetworkBrokenView
{
    [_networkBrokenView removeFromSuperview];
}


#pragma mark - toast

-(void)toast:(NSString *)title
{
    int seconds = 3;
    [self toast:title seconds:seconds];
}

-(void)toast:(NSString *)title seconds:(int)seconds
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.detailsLabelText = title;
    HUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的位置，不指定则在屏幕中间显示
    //    HUD.yOffset = 100.0f;
    //    HUD.xOffset = 100.0f;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(seconds);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}

-(void)toastWithError:(NSError *)error
{
    NSString *errorStr = [NSString stringWithFormat:@"网络出错：%@，code：%ld", error.domain, (long)error.code];
    [self toast:errorStr];
}

- (void)doClickNetworkBrokenView
{
    //由之类实现
}


#pragma mark - 如果用户没有登录则跳到登录页面

- (BOOL)gotoLoginPageIfNotLogin
{
    if (![User isUserLoginByStorage]) {
        UserLoginController *userLoginCtrl = [UserLoginController new];
        userLoginCtrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userLoginCtrl animated:YES];
        return YES;
    }
    return NO;
}

@end
