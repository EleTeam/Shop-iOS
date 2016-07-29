//
//  UserLoginController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/21.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserLoginController.h"
#import "UserRegisterStep1Controller.h"
#import "UserForgetPasswordController.h"
#import "UserLoginView.h"
#import "User.h"
#import "ValidatorUtil.h"

@interface UserLoginController () <UserLoginViewDelegate>
{
    UserLoginView *_vLoginView;
}
@end

@implementation UserLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"用户登录";
    
    _vLoginView = [[UserLoginView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    _vLoginView.delegate = self;
    [self.view addSubview:_vLoginView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UserLoginViewDelegate

- (void)doClickLoginBtnWithMobile:(NSString *)mobile password:(NSString *)password
{
    NSError *error = nil;
    if (![ValidatorUtil isValidMobile:mobile error:&error]) {
        [self toast:[error localizedDescription]];
        return;
    }
    if (password.length <= 0) {
        [self toast:@"密码不能为空"];
        return;
    }
    
    [self showLoadingView];
    [User loginWithMobile:mobile password:password success:^(BOOL status, NSNumber *code, NSString *message, User *user, NSString *app_cart_cookie_id) {
        if (status) {
            [self toast:@"登录成功"];
            sleep(2);
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [self toast:message];
        }
        [self hideLoadingView];
    } failure:^(NSError *error) {
        [self toastWithError:error];
        [self hideLoadingView];
    }];
}

- (void)doClickForgetBtn
{
    UserForgetPasswordController *ctrl = [UserForgetPasswordController new];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)doClickRegisterBtn
{
    UserRegisterStep1Controller *ctrl = [UserRegisterStep1Controller new];
    [self.navigationController pushViewController:ctrl animated:YES];
}

@end
