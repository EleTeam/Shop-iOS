//
//  OrderListController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/9/18.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "OrderListController.h"
#import "Order.h"
#import "OrderListCell.h"


@interface OrderListController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_mainTable;
    
    NSMutableArray *_orders; //根据下拉数据可添加个数
    
    NSNumber *_rough_status; //粗略的订单状态, 根据不同的值获取不同的数据
}
@end


@implementation OrderListController

- (instancetype)initWithRoughStatus:(NSNumber *)rough_status
{
    self = [super init];
    if (!self) return nil;

    _rough_status = rough_status;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([_rough_status isEqual:kRoughStatusPendingPay]) {
        self.title = @"待付款";
    }
    else if ([_rough_status isEqual:kRoughStatusDelivering]) {
        self.title = @"待收货";
    }
    else if ([_rough_status isEqual:kRoughStatusFinished]) {
        self.title = @"交易完成";
    }
    else {
        self.title = @"我的订单";
    }
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _mainTable.tableFooterView = [[UIView alloc]init];
    _mainTable.dataSource = self;
    _mainTable.delegate = self;
    
    [self.view addSubview:_mainTable];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData
{
    __weak typeof (self) weakSelf = self;
    [weakSelf showLoadingView];
    
    [Order getOrderListWithRoughStatus:_rough_status success:^(BOOL status, NSNumber *code, NSString *message, NSArray *orders) {
        if (status) {
            _orders = [orders mutableCopy];
            [_mainTable reloadData];
        } else {
            [weakSelf toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [weakSelf toastWithError:error];
        [weakSelf hideLoadingView];
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"OrderListCell";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[OrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier order:_orders[indexPath.row]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [OrderListCell height];
}

@end
