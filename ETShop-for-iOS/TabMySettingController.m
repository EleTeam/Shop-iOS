//
//  TabMySettingController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//  @open source https://github.com/YKXMall
//  @license The MIT License (MIT)
//

#import "TabMySettingController.h"

@interface TabMySettingController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    UITableView *_vTable;
}
@end

@implementation TabMySettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    _vTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _vTable.dataSource = self;
    _vTable.delegate = self;
    [self.view addSubview:_vTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (row == 0) {
            cell.textLabel.text = @"清除缓存";
        }
        else if (row == 1) {
            cell.textLabel.text = @"退出登录";
        }
    }
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [TabCartItemCell height];
//}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //退出登录
    NSInteger row = indexPath.row;
    if (row == 1) {
        UIAlertView *vAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [vAlert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    switch (buttonIndex) {
        case 0: //取消退出登录
            break;
        case 1: //确定退出登录
            [HttpClient requestJson:kUrlUserLogout params:nil success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                if (result) {
                    NSString *app_cart_cookie_id = [data objectForKey:kStorageAppCartCookieId];
                    [StorageUtil saveAppCartCookieId:app_cart_cookie_id];
                    [StorageUtil saveUserId:nil];
                    [StorageUtil saveUserLevel:nil];
                    [StorageUtil saveUserMobile:nil];
                    [StorageUtil saveAccessToken:nil];
                    [self toast:@"成功退出登录"];
                }
            } failure:^(NSError *error) {
            }];
            break;
    }
}

@end
