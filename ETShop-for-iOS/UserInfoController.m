//
//  UserInfoController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/21.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserInfoController.h"
#import "UserInfoView.h"

@interface UserInfoController ()
{
    User *_user;
    
    UserInfoView *_infoView;
}

@end

@implementation UserInfoController

- (instancetype)initWithUser:(User *)user
{
    self = [super init];
    if (!self) return nil;
    
    _user = user;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户信息";
    
    _infoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+kTopBarHeight, kScreenWidth, kScreenHeight) user:_user];
    [self.view addSubview:_infoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
