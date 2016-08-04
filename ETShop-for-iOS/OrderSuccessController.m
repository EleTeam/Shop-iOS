//
//  OrderSuccessController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/9/18.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "OrderSuccessController.h"
#import "OrderDetailController.h"
#import "OrderSuccessView.h"

@interface OrderSuccessController () <OrderSuccessViewDelegate>
{
    Order *_order;
    
    OrderSuccessView *_successView;
}

@end

@implementation OrderSuccessController

- (instancetype)initWithOrder:(Order *)order
{
    self = [super init];
    if (!self) return nil;

    _order = order;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单提交成功";
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    
    _successView = [[OrderSuccessView alloc] initWithFrame:CGRectMake(0, kNavBarHeight + kTopBarHeight, kScreenWidth, kScreenHeight) order:_order];
    _successView.delegate = self;
    
    [self.view addSubview:_successView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - OrderSuccessViewDelegate

- (void)doGotoShopping
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)doViewOrder
{
    OrderDetailController *ctrl = [[OrderDetailController alloc] initWithOrderId:_order.id];
    [self.navigationController pushViewController:ctrl animated:YES];
}

@end
