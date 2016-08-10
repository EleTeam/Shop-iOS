//
//  TabMyController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "TabMyController.h"
#import "UserLoginController.h"
#import "UserInfoController.h"
#import "TabMySettingController.h"
#import "OrderListController.h"
#import "LocationShopController.h"
#import "TabMyAboutUsController.h"
#import "User.h"
#import "TabMyHeadCell.h"
#import "TabMyOrderItemCell.h"
#import "TabMyCell.h"

// main table's section
typedef enum{
    eSectionHead = 0,
    eSectionOrder,
    eSectionCoupon,
    eSectionSupport
}eSection;


@interface TabMyController () <UITableViewDataSource, UITableViewDelegate, TabMyOrderItemCellDelegate>
{
    UITableView *_vTable;
    User *_user;
}
@end


@implementation TabMyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.navigationItem.leftBarButtonItem = nil;
    
    _vTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _vTable.tableFooterView = [[UIView alloc] init];
    _vTable.dataSource = self;
    _vTable.delegate = self;
    [self.view addSubview:_vTable];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //更新视图的用户信息
    NSNumber *user_id = [StorageUtil getUserId];
    NSString *user_mobile = [StorageUtil getUserMobile];
    NSNumber *user_level = [StorageUtil getUserLevel];
    NSString *user_level_label = [StorageUtil getUserLevelLabel];
    User *user = [User new];
    user.id = user_id;
    user.mobile = user_mobile;
    user.level = user_level;
    user.level_label = user_level_label;
    _user = user;
    [_vTable reloadData];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//更新本地用户信息，更新订单信息
- (void)getData
{
    __weak typeof (self) weakSelf = self;
    [weakSelf showLoadingView];
    
    //判断用户是否在服务器登录了，如果没有登录要清空用户信息
    [User getUser:^(BOOL status, NSNumber *code, NSString *message, User *user) {
        if (status) {
            _user = user;
            [_vTable reloadData];
        } else {
            //[weakSelf toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [weakSelf toastWithError:error];
        [weakSelf hideLoadingView];
    }];;
}


#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 10;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return eSectionSupport + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (eSectionHead == section) {
        return 1;
    }
    else if (eSectionOrder == section){
        return 2;
    }
    else if (eSectionCoupon == section) {
        return 3;
    }
    else if (eSectionSupport == section) {
        return 3;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    //eSectionHead
    if (eSectionHead == indexPath.section) {
        identifier = @"TabMyHeadCell";
        TabMyHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[TabMyHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell fillContentWithUser:_user];
        return cell;
    }
    //eSectionOrder
    else if (eSectionOrder == section) {
        if (row == 0) {
            identifier = @"TabMyCell";
            TabMyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[TabMyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_my_order" title:@"我的订单"];
            }
            return cell;
        } else {
            identifier = @"TabMyOrderItemCell";
            TabMyOrderItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[TabMyOrderItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.delegate = self;
            }
            return cell;
        }
    }
    //eSectionCoupon
    else if (eSectionCoupon == section) {
        identifier = @"TabMyCell";
        TabMyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            if (row == 0) {
                cell = [[TabMyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_my_coupon" title:@"优惠红包"];
            }
            else if (row == 1) {
                cell = [[TabMyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_my_collect" title:@"我的收藏"];
            }
            else {
                cell = [[TabMyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_my_history" title:@"最近浏览"];
            }
        }
        return cell;
    }
    //eSectionSupport
    else if (eSectionSupport == section) {
        identifier = @"TabMyCell";
        TabMyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            if (row == 0) {
                cell = [[TabMyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_location_light" title:@"店址导航"];
            }
            else if (row == 1) {
                cell = [[TabMyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_my_star" title:@"关于我们"];
            }
            else {
                cell = [[TabMyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_my_setting" title:@"设置"];
            }
        }
        return cell;
    }
    else {
        identifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (eSectionHead == indexPath.section) {
        return [TabMyHeadCell height];
    }
    else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    //eSectionHead
    if (eSectionHead == section) {
        if ([self gotoLoginPageIfNotLogin])
            return;
        
        if ([User isUserLoginByStorage]) {
            UserInfoController *userInfoCtrl = [[UserInfoController alloc] initWithUser:_user];
            userInfoCtrl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userInfoCtrl animated:YES];
        }
    }
    //eSectionOrder
    else if (eSectionOrder == section) {
        if ([self gotoLoginPageIfNotLogin])
            return;
        
        if (row == 0) {
            OrderListController *orderListCtrl = [[OrderListController alloc] initWithRoughStatus:nil];
            orderListCtrl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:orderListCtrl animated:YES];
        }
    }
    //eSectionCoupon
    else if (eSectionCoupon == section) {
        if ([self gotoLoginPageIfNotLogin])
            return;
        
        TabMyAboutUsController *ctrl = [TabMyAboutUsController new];
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    //eSectionSupport
    else if (eSectionSupport == section) {
        //店址导航
        if (row == 0) {
            LocationShopController *ctrl = [LocationShopController new];
            ctrl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ctrl animated:YES];
        }
        //关于我们
        else if (row == 1) {
            TabMyAboutUsController *ctrl = [TabMyAboutUsController new];
            ctrl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ctrl animated:YES];
        }
        //设置
        else if (row == 2) {
            TabMySettingController *ctrl = [TabMySettingController new];
            ctrl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ctrl animated:YES];
        }
    }
}


#pragma mark - TabMyOrderItemCellDelegate

- (void)doGotoOrderListPageWithRoughStatus:(NSString *)roughStatus
{
    if ([self gotoLoginPageIfNotLogin])
        return;
    
    OrderListController *orderListCtrl = [[OrderListController alloc] initWithRoughStatus:roughStatus];
    orderListCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderListCtrl animated:YES];
    
}

@end
