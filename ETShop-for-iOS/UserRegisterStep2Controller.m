//
//  UserRegisterStep2Controller.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/21.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserRegisterStep2Controller.h"
#import "UserRegisterStep3Controller.h"
#import "UserRegisterStep2View.h"
#import "ValidatorUtil.h"

@interface UserRegisterStep2Controller () <UserRegisterStep2ViewDelegate>
{
    UserRegisterStep2View *_vRegisterStep2View;
    NSString *_mobile;
}

@end

@implementation UserRegisterStep2Controller

- (instancetype)initWithMobile:(NSString *)mobile
{
    self = [super init];
    if (!self) return nil;
    
    _mobile = mobile;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户注册";
    
    _vRegisterStep2View = [[UserRegisterStep2View alloc] initWithFrame:CGRectMake(0, kNavBarHeight + kTopBarHeight, kScreenWidth, kScreenHeight)];
    _vRegisterStep2View.delegate = self;
    [self.view addSubview:_vRegisterStep2View];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UserRegisterStep2ViewDelegate

- (void)doClickNextBtnWithPassword:(NSString *)password
{
    NSError *error = nil;
    if ([ValidatorUtil isValidPassword:password error:&error]) {
        __weak typeof (self) weakSelf = self;
        [weakSelf showLoadingView];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            _mobile,    @"mobile",
                                            password,   @"password", nil];
        [HttpClient requestJson:kUrlUserRegisterStep2
                         params:params
                        success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                            [weakSelf hideLoadingView];
                            if (result) {
                                UserRegisterStep3Controller *ctrl = [[UserRegisterStep3Controller alloc] initWithMobile:_mobile password:password];
                                [self.navigationController pushViewController:ctrl animated:YES];
                            } else {
                                [weakSelf toast:message];
                            }
                        } failure:^(NSError *error) {
                            [weakSelf hideLoadingView];
                            [weakSelf toast:[error localizedDescription]];
                        }];
    } else {
        [self toast:[error localizedDescription]];
    }
}

@end
