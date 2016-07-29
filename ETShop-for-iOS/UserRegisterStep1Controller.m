//
//  UserRegisterStep1Controller.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/21.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserRegisterStep1Controller.h"
#import "UserRegisterStep2Controller.h"
#import "UserRegisterStep1View.h"
#import "ValidatorUtil.h"

@interface UserRegisterStep1Controller () <UserRegisterStep1ViewDelegate>
{
    UserRegisterStep1View *_vRegisterStep1View;
}

@end

@implementation UserRegisterStep1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户注册";
    
    _vRegisterStep1View = [[UserRegisterStep1View alloc] initWithFrame:CGRectMake(0, kNavBarHeight + kTopBarHeight, kScreenWidth, kScreenHeight)];
    _vRegisterStep1View.delegate = self;
    [self.view addSubview:_vRegisterStep1View];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UserRegisterStep1ViewDelegate

- (void)doClickNextBtnWithMobile:(NSString *)mobile
{
    NSError *error = nil;
    if ([ValidatorUtil isValidMobile:mobile error:&error]) {
        __weak typeof (self) weakSelf = self;
        [weakSelf showLoadingView];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:mobile forKey:@"mobile"];
        [HttpClient requestJson:kUrlUserRegisterStep1
                         params:params
                        success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                            [weakSelf hideLoadingView];
                            if (result) {
                                UserRegisterStep2Controller *ctrl = [[UserRegisterStep2Controller alloc] initWithMobile:mobile];
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
