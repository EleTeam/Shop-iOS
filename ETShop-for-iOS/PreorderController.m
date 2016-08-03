//
//  PreorderController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/11/01.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "PreorderController.h"
#import "AddressAddController.h"
#import "AddressListController.h"
#import "AddressEditController.h"
#import "OrderSuccessController.h"

#import "Preorder.h"
#import "Order.h"

#import "PreorderAddressCell.h"
#import "PreorderPayCell.h"
#import "PreorderItemsCell.h"
#import "PreorderNoteCell.h"
#import "PreorderCouponCell.h"
#import "PreorderSummaryCell.h"
#import "PreorderSubmitView.h"

typedef enum {
    eSectionAddress = 0,
    eSectionPay,
    eSectionProduct,
    eSectionNote,
    eSectionCoupon,
    eSectionSummary
}eSection;

@interface PreorderController () <UITableViewDataSource, UITableViewDelegate, PreorderAddressCellDelegate,
                                PreorderPayCellDelegate, PreorderNoteCellDelegate, PreorderSubmitViewDelegate>
{
    NSNumber *_preorder_id;
    Preorder *_preorder;
    __block Address *_address;
    NSString *_note; //订单备注
    
    UITableView *_vTable;
    PreorderSubmitView *_submitView;
    
    PreorderNoteCell *_noteCell; //放在这里声明是为了填写备注时，点击非键盘区域可以收起键盘
}

@end

@implementation PreorderController

- (instancetype)initWithPreorderId:(NSNumber *)preorder_id;
{
    self = [super init];
    if (!self) return nil;
    
    _preorder_id = preorder_id;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写订单";
    
    CGFloat submitViewHeight = [PreorderSubmitView height];
    CGFloat tableHeight = kScreenHeight - submitViewHeight;
    
    _vTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, tableHeight)];
    [_vTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _vTable.dataSource = self;
    _vTable.delegate = self;
    
    _submitView = [[PreorderSubmitView alloc] initWithFrame:CGRectMake(0, tableHeight, kScreenWidth, submitViewHeight)];
    _submitView.delegate = self;
    
    [self.view addSubview:_vTable];
    [self.view addSubview:_submitView];
    
    //监听改变preorder事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resetAddress:)
                                                 name:kNotifyPreorderAddressDidChanged
                                               object:nil];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData
{
    __weak typeof (self) weakSelf = self;
    [weakSelf showLoadingView];
    [Preorder getWithId:_preorder_id
                success:^(BOOL status, NSNumber *code, NSString *message, Preorder *preorder, Address *address) {
                    if (status) {
                        _preorder = preorder;
                        _address = address;
                        [_vTable reloadData];
                        [_submitView fillContentWithPreorder:_preorder];
                    } else {
                        [self toast:message];
                    }
                    [self hideLoadingView];
                } failure:^(NSError *error) {
                    [self toastWithError:error];
                    [self hideLoadingView];
                }];
}

//响应通知中心的方法
- (void)resetAddress:(NSNotification *)notification
{
    Address *address = [[notification userInfo] objectForKey:@"address"];
    if (address.id > 0) {
        _address = address;
    }
    [_vTable reloadData];
}
     

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return eSectionSummary + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_preorder.preorderItems.count > 0) {
        return 1;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    NSInteger section = indexPath.section;
    if (section == eSectionAddress) {
        identifier = @"PreorderAddressCell";
        PreorderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PreorderAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.delegate = self;
        }
        [cell fillContentWithAddress:_address];
        return cell;
    }
    else if (section == eSectionPay) {
        identifier = @"PreorderPayCell";
        PreorderPayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PreorderPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.delegate = self;
        }
        [cell setPayType:_preorder.pay_type];
        return cell;
    }
    else if (section == eSectionProduct) {
        identifier = @"PreorderItemsCell";
        PreorderItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PreorderItemsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier preorderItems:_preorder.preorderItems];
        }
        return cell;
    }
    else if (section == eSectionNote) {
        identifier = @"PreorderNoteCell";
        _noteCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!_noteCell) {
            _noteCell = [[PreorderNoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return _noteCell;
    }
    else if (section == eSectionCoupon) {
        identifier = @"PreorderCouponCell";
        PreorderCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PreorderCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
    else if (section == eSectionSummary) {
        identifier = @"PreorderSummaryCell";
        PreorderSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PreorderSummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell fillContentWithPreorder:_preorder];
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    NSInteger section = indexPath.section;
    if (section == eSectionAddress) {
        height = [PreorderAddressCell height];
    }
    else if (section == eSectionPay) {
        height = [PreorderPayCell height];
    }
    else if (section == eSectionProduct) {
        height = [PreorderItemsCell heightWithPreorderItems:_preorder.preorderItems];
    }
    else if (section == eSectionNote) {
        height = [PreorderNoteCell height];
    }
    else if (section == eSectionNote) {
        height = [PreorderNoteCell height];
    }
    else if (section == eSectionCoupon) {
        height = [PreorderCouponCell height];
    }
    else if (section == eSectionSummary) {
        height = [PreorderSummaryCell height];
    }
    return height;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 3;
    if (section == eSectionSummary) {
        height = 0;
    }
    return height;
}

#pragma mark - PreorderAddressCellDelegate
- (void)doClickAddressCell
{
    AddressListController *ctrl = [AddressListController new];
    [self.navigationController pushViewController:ctrl animated:YES];
}

#pragma mark - PreorderPayCellDelegate
- (void)doSelectPayType:(NSNumber *)pay_type
{
    __weak typeof (self) weakSelf = self;
    [weakSelf showLoadingView];
    [Preorder setPayTypeWithId:_preorder.id
                                    payType:pay_type
                                    success:^(BOOL status, NSNumber *code, NSString *message, Preorder*preorder) {
                                        if (status) {
                                            _preorder = preorder;
                                            [_vTable reloadData];
                                        } else {
                                            [weakSelf toast:message];
                                        }
                                        [weakSelf hideLoadingView];
                                    } failure:^(NSError *error) {
                                        [weakSelf toastWithError:error];
                                        [weakSelf hideLoadingView];
                                    }];
}


#pragma mark -  PreorderNoteCellDelegate

//订单备注
- (void)doNoteFinished:(NSString *)note
{
    _note = note;
}


#pragma  mark - PreorderSubmitViewDelegate

- (void)doClickSubmitBtn
{
    __weak typeof (self) weakSelf = self;
    [weakSelf showLoadingView];
    
    [Order addWithPreorderId:_preorder.id
                        addressId:_address.id
                           notice:_note
                          success:^(BOOL status, NSNumber *code, NSString *message, Order *order) {
                              if (status) {
                                  OrderSuccessController *ctrl1 = [[OrderSuccessController alloc] initWithOrder:order];
                                  [self.navigationController pushViewController:ctrl1 animated:YES];
                              } else {
                                  [weakSelf toast:message];
                              }
                              [weakSelf hideLoadingView];
                          } failure:^(NSError *error) {
                              [weakSelf toastWithError:error];
                              [weakSelf hideLoadingView];
                          }];
}



//点击空白区域收起键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_noteCell closeKeyboard];
}

@end
