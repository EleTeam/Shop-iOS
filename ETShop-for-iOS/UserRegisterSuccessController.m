//
//  UserRegisterSuccessController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/21.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserRegisterSuccessController.h"
#import "UserRegisterSuccessView.h"

@interface UserRegisterSuccessController () <UserRegisterSuccessViewDelegate>
{
    UserRegisterSuccessView *_vRegisterSuccessView;
    NSString *_mobile;
    NSString *_password;
}
@end

@implementation UserRegisterSuccessController

- (instancetype)initWithMobile:(NSString *)mobile password:(NSString *)password
{
    self = [super init];
    if (!self) return nil;
    
    _mobile = mobile;
    _password = password;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户注册";
    
    _vRegisterSuccessView = [[UserRegisterSuccessView alloc] initWithFrame:CGRectMake(0, kNavBarHeight + kTopBarHeight, kScreenWidth, kScreenHeight)];
    _vRegisterSuccessView.delegate = self;
    [_vRegisterSuccessView fillContentWithLoginName:_mobile password:_password];
    [self.view addSubview:_vRegisterSuccessView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doClickShoppingBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
