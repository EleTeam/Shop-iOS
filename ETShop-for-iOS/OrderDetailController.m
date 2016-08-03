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
#import "Order.h"

#import "OrderDetailStatusCell.h"

typedef enum{
    eSectionStatus = 0
}eSection;

@interface OrderDetailController () <UITableViewDataSource, UITableViewDelegate>
{
    NSNumber *_order_id;
    Order *_order;
    
    UITableView *_mainTable;
}
@end

@implementation OrderDetailController

- (instancetype)initWithOrderId:(NSNumber *)order_id
{
    self = [super init];
    if (!self) return nil;
    
    _order_id = order_id;
    
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
    
    [Order getOrderWithId:_order_id
                       success:^(BOOL status, NSNumber *code, NSString *message, Order *order) {
                           if (status) {
                               _order = order;
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
    if (_order.id > 0) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_order.id > 0) {
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
