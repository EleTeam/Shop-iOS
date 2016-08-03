//
//  TabCartController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//
#import "TabCartController.h"
#import "UserLoginController.h"
#import "PreorderController.h"
#import "Cart.h"
#import "TabCartItemCell.h"
#import "TabCartSubmitBar.h"
#import "Preorder.h"

@interface TabCartController () <UITableViewDataSource, UITableViewDelegate, TabCartItemCellDelegate, TabCartSubmitBarDelegate>
{
    UITableView *_mainTable;
    TabCartSubmitBar *_vSubmitBar;
    NSArray *_cartItems; //购物车里的项
    NSArray *_couponUsers;
    NSNumber *_total_price;
}

@end


@implementation TabCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"购物车";
    
    CGFloat submitBarHeight = [TabCartSubmitBar height];
    CGFloat submitBarTop = kScreenHeight - submitBarHeight - kNavBarHeight;
    CGFloat mainTableHeight = kScreenHeight - kNavBarHeight - submitBarHeight;
    _vSubmitBar = [[TabCartSubmitBar alloc] initWithFrame:CGRectMake(0, submitBarTop, kScreenWidth, submitBarHeight)];
    _vSubmitBar.delegate = self;
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, mainTableHeight)];
    _mainTable.tableFooterView = [[UIView alloc]init];
    _mainTable.dataSource = self;
    _mainTable.delegate = self;
    
    [self.view addSubview:_mainTable];
    [self.view addSubview:_vSubmitBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showLoadingView];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData
{
    __weak typeof (self) weakSelf = self;
    [Cart getCart:^(BOOL status, NSString *message, NSMutableArray *cartItems, NSArray *couponUsers, NSNumber *cart_num, NSNumber *total_price, BOOL isLoggedIn) {
        _cartItems = cartItems;
        _couponUsers = couponUsers;
        _total_price = total_price;
        [_vSubmitBar setCartNum:cart_num];
        
        [_mainTable reloadData];
        [self hideLoadingView];
        [self hideNetworkBrokenView];
    } failure:^(NSError *error) {
        //网络没有连接
        if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorNotConnectedToInternet) {
            [weakSelf showNetworkBrokenView:nil];
        } else {
            [weakSelf toastWithError:error];
        }
        [weakSelf hideLoadingView];
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cartItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"TabCartItemCell";
    TabCartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TabCartItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell fillContentWithCartItem:_cartItems[indexPath.row] couponUser:_couponUsers total_price:_total_price];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TabCartItemCell height];
}


#pragma mark - TabCartItemCellDelegate

- (void)doClickMinus:(TabCartItemCell *)sender
{
    NSNumber *item_id = sender.cartItemId;
    NSNumber *count = [sender getCount];
    if (item_id > 0 && [count intValue] >= 2) {
        count = [NSNumber numberWithInt:[count intValue]-1];
        [self setCartItemCountWithItemId:item_id count:count sender:sender];
    }
}

- (void)doClickPlus:(TabCartItemCell *)sender
{
    NSNumber *item_id = sender.cartItemId;
    NSNumber *count = [sender getCount];
    if (item_id > 0 && [count intValue] >= 0) {
        count = [NSNumber numberWithInt:[count intValue]+1];
        [self setCartItemCountWithItemId:item_id count:count sender:sender];
    }
}

- (void)setCartItemCountWithItemId:(NSNumber *)item_id count:(NSNumber *)count sender:(TabCartItemCell *)sender
{
    [self showLoadingView];
    __weak typeof (self) weakSelf = self;
    [Cart setCartItemCountWithItemId:item_id count:count success:^(BOOL result, NSString *message, NSNumber *cart_num, NSNumber *total_price) {
        if (result) {
            [sender setCount:count];
        } else {
            [self toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [self toastWithError:error];
        [weakSelf hideLoadingView];
    }];
}

- (void)doClickDelete:(TabCartItemCell *)sender
{
    [self showLoadingView];
    NSNumber *item_id = sender.cartItemId;
    __weak typeof (self) weakSelf = self;
    [Cart deleteCartItemWithItemId:item_id success:^(BOOL status, NSString *message, NSNumber *cart_num, NSNumber *total_price) {
        if (status) {
            [self getData];
        } else {
            [self toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [self toastWithError:error];
        [weakSelf hideLoadingView];
    }];
}

- (void)doClickSelect:(TabCartItemCell *)sender is_selected:(NSNumber *)is_selected
{
    [self showLoadingView];
    NSNumber *item_id = sender.cartItemId;
    __weak typeof (self) weakSelf = self;
    [Cart selectCartItemWithItemId:item_id is_selected:is_selected success:^(BOOL result, NSString *message, NSNumber *cart_num, NSNumber *total_price) {
        if (result) {
            [self getData];
            [sender setIsSelectedBy:is_selected];
        } else {
            [self toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [self toastWithError:error];
        [weakSelf hideLoadingView];
    }];
}

- (void)doClickSubmitCartBtn
{
    __weak typeof (self) weakSelf = self;
    [self showLoadingView];
    
    //用户没有登陆则跳到登陆页面
    [Preorder add:^(BOOL result, NSNumber *code, NSString *message, NSNumber *id) {
        NSNumber *resultCodeUserNotLogedin = kResultCodeUserNotLogedin;
        NSNumber *resultCodeUserSuccess = kResultCodeSuccess;
        if ([code isEqual:resultCodeUserNotLogedin]) {
            UserLoginController *userController = [UserLoginController new];
            userController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userController animated:YES];
        }
        else if ([code isEqual:resultCodeUserSuccess]) {
            PreorderController *preorderController = [[PreorderController alloc] initWithPreorderId:id];
            preorderController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:preorderController animated:YES];
        } else {
            [self toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [self toastWithError:error];
        [weakSelf hideLoadingView];
    }];
}

- (void)doClickNetworkBrokenView
{
    [self showLoadingView];
    [self getData];
}

@end
