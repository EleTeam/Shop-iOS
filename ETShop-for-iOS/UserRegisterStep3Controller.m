//
//  UserRegisterStep3Controller.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/21.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserRegisterStep3Controller.h"
#import "UserRegisterSuccessController.h"
#import "UserRegisterStep3View.h"
#import "User.h"

@interface UserRegisterStep3Controller () <UserRegisterStep3ViewDelegate>
{
    UserRegisterStep3View *_vRegisterStep3View;
    NSString *_mobile;
    NSString *_password;
}

@end

@implementation UserRegisterStep3Controller

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
    
    _vRegisterStep3View = [[UserRegisterStep3View alloc] initWithFrame:CGRectMake(0, kNavBarHeight + kTopBarHeight, kScreenWidth, kScreenHeight)];
    _vRegisterStep3View.delegate = self;
    [self.view addSubview:_vRegisterStep3View];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UserRegisterStep3ViewDelegate

- (void)doClickNextBtnWithCode:(NSString *)code
{
    if (code.length < 1) {
        [self toast:@"请输入验证码"];
        return;
    }
    
    __weak typeof (self) weakSelf = self;
    [weakSelf showLoadingView];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       _mobile,     @"mobile",
                                       _password,   @"password",
                                       code,        @"code", nil];
    [HttpClient requestJson:kUrlUserRegisterStep3
                     params:params
                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
                            [weakSelf hideLoadingView];
                            if (status) {
                                //用户注册成功后，保存用户信息
                                User *user = [User mj_objectWithKeyValues:[data objectForKey:@"user"]];
                                NSString *app_cart_cookie_id = [data objectForKey:@"app_cart_cookie_id"];
                                [StorageUtil saveUserId:user.id];
                                [StorageUtil saveUserMobile:user.mobile];
                                [StorageUtil saveUserLevel:user.level];
                                [StorageUtil saveAccessToken:user.access_token];
                                [StorageUtil saveAppCartCookieId:app_cart_cookie_id];
                                
                                //打开注册成功页面
                                UserRegisterSuccessController *ctrl = [[UserRegisterSuccessController alloc] initWithMobile:_mobile password:_password];
                                [self.navigationController pushViewController:ctrl animated:YES];
                            } else {
                                [weakSelf toast:message];
                            }
                        } failure:^(NSError *error) {
                            [weakSelf hideLoadingView];
                            [weakSelf toast:[error localizedDescription]];
                        }];
    
}

@end
