//
//  OrderDetailController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/9/18.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "OrderDetailController.h"
#import "OrderEntity.h"
#import "OrderItemEntity.h"
#import "OrderModel.h"

#import "OrderDetailStatusCell.h"

typedef enum{
    eSectionStatus = 0
}eSection;

@interface OrderDetailController () <UITableViewDataSource, UITableViewDelegate>
{
    NSString *_orderId;
    OrderEntity *_order;
    NSArray *_orderItems;
    
    UITableView *_mainTable;
}
@end

@implementation OrderDetailController

- (instancetype)initWithOrderId:(NSString *)orderId
{
    self = [super init];
    if (!self) return nil;
    
    _orderId = orderId;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看订单";
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
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
    
    [OrderModel getOrderWithId:_orderId
                       success:^(BOOL result, NSNumber *resultCode, NSString *message, OrderEntity *order, NSArray *orderItems) {
                           if (result) {
                               _order = order;
                               _orderItems = orderItems;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_order.id.length > 0) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_order.id.length > 0) {
        return 1;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSString *identifier;
    
    if (eSectionStatus == section) {
        identifier = @"OrderDetailStatusCell";
        OrderDetailStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OrderDetailStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier order:_order];
        }
        return cell;
    }
    else {
        identifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
}


#pragma mark - UITableViewDelegate


@end
